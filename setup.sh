#!/bin/bash

if [ -z "$1" ]; then
echo "Error: The parameter is your domain name!"
echo "Usage: $0 domain"
exit 1
fi

domain=$1
username=$(whoami)
random_port=$((RANDOM % 40001 + 20000))

echo "to /home/$username/domains/$domain/public_html/index.js"
curl -s -o "/home/$username/domains/$domain/public_html/index.js" "https://raw.githubusercontent.com/frankiejun/node-ws/main/index.js"
if [ $? -ne 0 ]; then
echo "Error: Failed to download the script index.js!"
exit 1
fi
curl -s -o "/home/$username/cron.sh"  "https://raw.githubusercontent.com/frankiejun/node-ws/main/cron.sh"
if [ $? -ne 0 ]; then
echo "Error: Failed to download script cron.sh!"
exit 1
fi
chmod +x /home/$username/cron.sh

read -p "Input UUID:" uuid
if [ -z "$uuid" ]; then
echo "Error: UUID cannot be empty!"
exit 1
fi
echo "The UUID you entered: $uuid"
read -p "Do you want to install the probe? [y/n] [n]:" input
input=${input:-n}
if [ "$input" != "n" ]; then
read -p "Input NEZHA_SERVER (Nezha v1 fill in the form: nz.abc.com:8008, Nezha v0 fill in the form: nz.abc.com):"  nezha_server
if [ -z "$nezha_server" ]; then
echo "Error: nezha_server cannot be empty!"
exit 1
fi
read -p "Enter NEZHA_PORT (Press Enter here on the v1 panel, and enable tls when the agent port of v0 is one of {443,8443,2096,2087,2083,2053}):" nezha_port
nezha_port=${nezha_port:-""}
read -p "Enter NEZHA_KEY (NZ_CLIENT_SECRET of v1 or agent port of v0):" nezha_key
if [ -z "$nezha_key" ]; then
echo "Error: nezha_key cannot be empty!"
exit 1
fi
fi
echo "The nezha_server you entered: $nezha_server, nezha_port:$nezha_port,  nezha_key:$nezha_key"



 sed -i "s/NEZHA_SERVER || ''/NEZHA_SERVER || '$nezha_server'/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/NEZHA_PORT || ''/NEZHA_PORT || '$nezha_port'/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/NEZHA_KEY || ''/NEZHA_KEY || '$nezha_key'/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/#DOMAIN#/$domain/g" "/home/$username/domains/$domain/public_html/index.js"
 sed-i  "s/#PORT#;/$random_port;/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s/#UUID#/$uuid/g" "/home/$username/domains/$domain/public_html/index.js"
 sed -i "s|/HOME|/home/$username|g" "/home/$username/domains/$domain/public_html/index.js"

 if [ "$input" = "y" ]; then
     sed -i "s/nezha_check=false/nezha_check=true/g" "/home/$username/cron.sh"
 fi


 cat > "/home/$username/domains/$domain/public_html/package.json" << EOF
 {
   "name": "node-ws",
   "version": "1.0.0",
   "description": "Node.js  Server",
   "main": "index.js",
   "author": "fkj",
   "repository": "https://github.com/frankiejun/node-ws",
   "license": "MIT",
   "private": false,
   "scripts": {
     "start": "node index.js"
   },
   "dependencies": {
     "ws": "^8.14.2",
     "axios": "^1.6.2",
     "mime-types": "^2.1.35"
   },
   "engines": {
     "node": ">=14"
   }
 }
 EOF

 echo "*/1 * * * * cd /home/$username/public_html && /home/$username/cron.sh" > ./mycron
 crontab ./mycron >/dev/null 2>&1
 rm ./mycron

 echo "Installation completed"
