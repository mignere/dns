#!/bin/bash

#getting the ip information
#read the domain user want to use
read -p "input the domain you want to use : " domain
echo "this is the domain you will use : $domain"
sleep 2

#read the user dns forwarder selection
read -p "choose dns you want to use as a forwarders : " dns
echo "this is the dns you will use as a forwarders : $dns"
sleep 2

#read user input for ip address variable
read -p "input ip address you want to use : " ip
echo "this is the ip you will use for $domain : $ip"
sleep 2

#making the raw reversed ip for user
ip_reverse_raw="${ip#192.}"
echo "this is your raw reverse ip : $ip_reverse_raw "
sleep 2

read -p "please input the reversed ip, example = 168.1.2 = 2.1.168 : " ip_reverse
echo "this is your reversed ip : $ip_reverse"
sleep 2

#user db forward lookup zone name and reverse lookup zone name
db_forward=$domain
db_reverse=db.rev

#updating the repository
echo "updating repository"
sleep 2
apt update

#installing the needed packages
echo "installing needed packages"
sleep 2
apt install bind9 bind9utils dnsutils -y

#creating the backup directory
echo "creating backup directory"
sleep 2
mkdir /backup

#copying the default conf to backup dir
echo "copying all default configuration to backup directory"
sleep 2
cp /etc/bind/* /backup
cp /etc/bind/* /backup

#creating your configuration file
echo "creating your configuration file"
sleep 2
cp /etc/bind/db.local /etc/bind/$db_forward
cp /etc/bind/db.127 /etc/bind/$db_reverse
cp /etc/bind/named.conf.default-zones /etc/bind/named.conf.local

#editing your config
echo "editing your configuration"
sleep 2
#db forward lookup zone
sed -i 's/localhost/'$domain'/g' /etc/bind/$db_forward
sed -i 's/127.0.0.1/'$ip'/g' /etc/bind/$db_forward
sed -i '/@	IN	AAAA/d' /etc/bind/$db_forward
#db reverse lookup zone
sed -i 's/localhost/'$domain'/g' /etc/bind/$db_reverse
sed -i 's/1.0.0/'$ip_reverse'/g' /etc/bind/$db_reverse
#named.conf.local
sed -i '19,30d' /etc/bind/named.conf.local
sed -i '1,9d' /etc/bind/named.conf.local
sed -i 's/localhost/'$domain'/g' /etc/bind/named.conf.local
sed -i 's/db.local/'$db_forward'/g' /etc/bind/named.conf.local
sed -i 's/db.127/'$db_reverse'/g' /etc/bind/named.conf.local
sed -i 's/127/192/g' /etc/bind/named.conf.local
#named.conf.options
sed -i '13,15s/\/\///' /etc/bind/named.conf.options
sed -i 's/0.0.0.0/'$dns'/g' /etc/bind/named.conf.options
sed -i '22 i recursion yes;' /etc/bind/named.conf.options
sed -i '23 i forward only;' /etc/bind/named.conf.options

#restarting bind9
echo "restarting bind9"
sleep 2
systemctl restart bind9

#configuring resolver
echo "changing resolver"
sleep 2
echo "nameserver $ip" > /etc/resolv.conf

#done
echo "congrats, domain $domain has been successfully made."
sleep 1
echo "sasuga mignere san :33333"
