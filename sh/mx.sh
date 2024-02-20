#!/bin/bash

#getting the information needed
read -p "input the domain which you want to add the mx record : " domain
read -p "where should this domain mx record points to? (example:mail.mignere.com) : " point

#user configuration file var
db_forward=$domain
db_reverse=$domain.rev

#adding mx record
echo "$domain.	IN	MX 10	$point." >> /etc/bind/$db_forward

#restarting bind9
systemctl restart bind9

#done
echo "congrats, now the $domain have an mx record pointing to $point"
echo "sasuga mignere san <3333"
