#!/bin/bash

#getting the information
read -p "which domain do you want to add a subdomain? : " domain
read -p "please input the full ip address of the domain : " ip

ip_reverse=$(echo $ip | awk -F '.' '{print $4"."$3"."$2}')
echo "this is your reversed ip : $ip_reverse"
sleep 2

read -p "what subdomain would you like to add? (example: mail/www/ftp/pma) : " subdomain

#editing configuration
echo "editing configuration"
sleep 2
echo "$subdomain        IN      A       $ip" >> /etc/bind/$domain
echo "$ip_reverse       IN      PTR     $subdomain.$domain." >> /etc/bind/db.rev

#restarting bind9
echo "restarting bind9"
sleep 2
systemctl restart bind9

#done
echo "congrats, your $subdomain subdomain has been successfully made!"
sleep 1
echo "sasuga mignere san <333"
