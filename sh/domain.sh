#!/bin/bash

#getting the ip information
#read the domain user want to use
read -p "input the domain you want to add : " domain
echo "this is the domain you will add : $domain"

#read user input for ip address variable
read -p "input the ip address for this domain : " ip
echo "this is the ip you will use for $domain : $ip"

#making the raw reversed ip for user
ip_reverse_raw="${ip#192.}"
echo "this is your raw reverse ip : $ip_reverse_raw "

read -p "please input the reversed ip, example = 168.1.2 = 2.1.168 : " ip_reverse
echo "this is your reversed ip : $ip_reverse"

#user db forward lookup zone name and reverse lookup zone name
db_forward=$domain
db_reverse=db.rev

#creating your configuration file
echo "creating your configuration file"
cp /etc/bind/db.local /etc/bind/$db_forward
sed -n '10,13p' /etc/bind/named.conf.default-zones >> /etc/bind/named.conf.local

#editing your config
echo "editing your configuration"
#db forward lookup zone
sed -i 's/localhost/'$domain'/g' /etc/bind/$db_forward
sed -i 's/127.0.0.1/'$ip'/g' /etc/bind/$db_forward
sed -i '/@	IN	AAAA/d' /etc/bind/$db_forward
#db reverse lookup zone
echo "$ip_reverse	IN	PTR	$domain." >> /etc/bind/$db_reverse
#named.conf.local
sed -i 's/localhost/'$domain'/g' /etc/bind/named.conf.local
sed -i 's/db.local/'$db_forward'/g' /etc/bind/named.conf.local

#restarting bind9
echo "restarting bind9"
systemctl restart bind9

#done
echo "congrats, domain $domain has been successfully added."
echo "sasuga mignere san :33333"
