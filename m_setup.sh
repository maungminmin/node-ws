#!/bin/bash

if [ -z "$1" ]; then
echo "Error: The parameter is your domain name!"
echo "Usage: $0 domain"
exit 1
fi

domain=$1
username=$(whoami)
random_port=$((RANDOM % 40001 + 20000))

read -p "Input UUID:" uuid
if [ -z "$uuid" ]; then
echo "Error: UUID cannot be empty!"
exit 1
fi
echo "UUID you entered: $uuid"
read -p "Do you want to install the probe? [y/n] [n]:" input
input=${input:-n}
if [ "$input" != "n" ]; then
read -p  "Enter NEZHA_SERVER (Nezha v1 fill in the form: nz.abc.com:8008, Nezha v0 fill in the form: nz.abc.com):" nezha_server
if [ -z "$nezha_server" ]; then
echo "Error: nezha_server cannot be empty!"
exit 1
fi
read -p "Enter NEZHA_PORT (Press Enter here on the v1 panel, and enable tls when the agent port of v0 is {443,8443,2096,2087,2083,2053}):" nezha_port
nezha_port=${nezha_port:-""}
read -p "Enter NEZHA_KEY (NZ_CLIENT_SECRET of v1 or agent port of v0):" nezha_key
if [ -z "$nezha_key" ]; then
echo "Error:  nezha_key cannot be empty!  "
     exit 1
   fi
 fi
 echo "The nezha_server you entered: $nezha_server, nezha_port:$nezha_port, nezha_key:$nezha_key"

 sed -i "s/NEZHA_SERVER || ''/NEZHA_SERVER || '$nezha_server'/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/NEZHA_PORT || ''/NEZHA_PORT || '$nezha_port'/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/NEZHA_KEY || ''/NEZHA_KEY || '$nezha_key'/g"  "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/#DOMAIN#/$domain/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/#PORT#;/$random_port;/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/#UUID#/$uuid/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s|/HOME|/home/$username|g" "/home/$username/domains/$domain/public_html/index.js"


 echo "Installation completed"
