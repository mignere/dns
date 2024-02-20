#!/bin/bash

#getting user intention
read -p "what would you like to do? (setup/domain/subdomain/mx) : " ans

#executing user command
if [ "$ans" = "setup" ]
#setup
then
 echo "starting the setup"
 bash ~/Bind9/sh/install-en.sh
#domain
elif [ "$ans" = "domain" ]
then
 echo "adding new domain"
 bash ~/Bind9/sh/domain.sh
#subdomain
elif [ "$ans" = "subdomain" ]
then
 echo "adding a subdomain"
 bash ~/Bind9/sh/sub.sh
#mx
elif [ "$ans" = "mx" ]
then
 echo "making the mx record"
 bash ~/Bind9/sh/mx.sh
else
 echo "sorry, invalid input"
fi






