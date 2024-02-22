#!/bin/bash

#deleting all configured file
echo "deleting all configured file"
sleep 2
rm -r /etc/bind/*

#copying pure file from the backup dir
echo "copying pure file from the backup dir"
sleep 2
cp /backup/* /etc/bind

#changing resolver
echo "changing resolver"
sleep 2
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

#restarting bind9
echo "restarting bind9"
sleep 2
systemctl restart bind9

#done
echo "done, now your bind9 config has been resetted"
sleep 2
echo "sasuga mignere san <333333"
