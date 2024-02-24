#!/bin/bash

#getting the ip information
#read the domain user want to use
read -p "input the domain you want to add : " domain
echo "this is the domain you will add : $domain"

#read user input for ip address variable
read -p "input the ip address for this domain : " ip
echo "this is the ip you will use for $domain : $ip"

#making the raw reversed ip for user
ip_reverse_raw=$(echo $ip | awk -F '.' '{print $2"."$3"."$4}')
echo "this is your raw reversed ip : $ip_reverse_raw "
sleep 2

ip_reverse=$(echo $ip | awk -F '.' '{print $4"."$3"."$2}')
echo "this is your reversed ip : $ip_reverse"
sleep 2

#first octet for named.conf.local
foctet=$(echo $ip | awk -F '.' '{print $1}')

#user db forward lookup zone name and reverse lookup zone name
db_forward=$domain
db_reverse=db.rev

#creating your configuration file
echo "creating your configuration file"
sleep 2
cp /etc/bind/db.local /etc/bind/$db_forward
sed -n '10,13p' /etc/bind/named.conf.default-zones >> /etc/bind/named.conf.local

#editing your config
echo "editing your configuration"
sleep 2
#db forward lookup zone
sed -i 's/localhost/'$domain'/g' /etc/bind/$db_forward
sed -i 's/127.0.0.1/'$ip'/g' /etc/bind/$db_forward
sed -i '/@	IN	AAAA/d' /etc/bind/$db_forward
#db reverse lookup zone
echo "$ip_reverse	IN	PTR	$domain." >> /etc/bind/$db_reverse
#named.conf.local
sed -i 's/localhost/'$domain'/g' /etc/bind/named.conf.local
sed -i 's/db.local/'$db_forward'/g' /etc/bind/named.conf.local
#checking for reverse zone file
if grep -q "$foctet.in-addr.arpa" /etc/bind/named.conf.local; then
    echo "reverse zone already made, proceeding..."
    sleep 2
else
    echo "$foctet.in-addr.arpa doesnt found in the reverse zone file, making a new one..."
    sleep 2
    sed -n '15,18p' /etc/bind/named.conf.default-zones >> /etc/bind/named.conf.local
    sed -i 's/db.127/'$db_reverse'/g' /etc/bind/named.conf.local
    sed -i 's/127/'$foctet'/g' /etc/bind/named.conf.local
fi

#restarting bind9
echo "restarting bind9"
sleep 2
systemctl restart bind9

#done
echo "congrats, domain $domain has been successfully added."
sleep 1
echo "sasuga mignere san :33333"
