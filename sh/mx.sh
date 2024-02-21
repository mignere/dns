#!/bin/bash

#getting the information needed
read -p "input the domain which you want to add the mx record : " domain
read -p "where should this domain mx record points to? (example:mail.mignere.com) : " point

#user configuration file var
db_forward=$domain
db_reverse=db.rev

#adding mx record
echo "adding mx record..."
sleep 2
echo "$domain.	IN	MX 10	$point." >> /etc/bind/$db_forward

#restarting bind9
echo "restarting bind9"
sleep 2
systemctl restart bind9

#done
echo "congrats, now the $domain have an mx record pointing to $point"
sleep 1
echo "sasuga mignere san <3333"
