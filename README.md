mignere's bind9 little automation
1.clone this repo only to the **home directory** of the user, or else it wont work
2.the scripts must be executed with root user or user with sudo privileges
3.the main script is **init.sh**, once you clone this repo, that's gonna be the first thing you wanna execute
4.once you execute the init.sh script. there will be 4 types of configuration, and those are :
  1.setup
    this mode will install bind9 package, setup the domain you want to use, the forward lookup zone, reverse lookup zone, named.local.conf, and named.conf.options
  2.domain
    this mode will add another domain under the same reverse zone config as the one you made using setup mode.
  3.subdomain
    this mode enable you to add a subdomain for a domain that you prompt
  4.mx
    this mode will create an mx record for a domain that you prompt
    


