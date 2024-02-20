#!/bin/bash

#getting the information
read -p "which domain do you want to add a subdomain? : " domain
read -p "please input the full ip address of the domain : " ip
read -p "what subdomain would you like to add? (example: mail/www/ftp/pma) : " subdomain

#editing configuration
echo "editing configuration"
echo "$subdomain	IN	A	$ip" >> /etc/bind/$domain

#restarting bind9
systemctl restart bind9

#done
echo "congrats, your $subdomain subdomain has been successfully made!"
echo "sasuga mignere san <333"

