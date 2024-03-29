#!/bin/bash

#getting user intention
read -p "what would you like to do? (setup/domain/subdomain/mx/reset) : " ans

#executing user command
if [ "$ans" = "setup" ]
#setup
then
 echo "starting the setup"
 sleep 2
 bash ~/dns-Bind9/sh/install-en.sh
#domain
elif [ "$ans" = "domain" ]
then
 echo "adding new domain"
 sleep 2
 bash ~/dns-Bind9/sh/domain.sh
#subdomain
elif [ "$ans" = "subdomain" ]
then
 echo "adding a subdomain"
 sleep 2
 bash ~/dns-Bind9/sh/sub.sh
#mx
elif [ "$ans" = "mx" ]
then
 echo "making the mx record"
 sleep 2
 bash ~/dns-Bind9/sh/mx.sh
#reset
elif [ "$ans" = "reset" ]
then
 echo "resetting the configuration"
 sleep 2
 bash ~/dns-Bind9/sh/reset.sh
else
 echo "sorry, invalid input"
fi
