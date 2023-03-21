#!/bin/bash

#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# nano 0a1b_basicWebServer.sh
# sudo chmod +x 0a1b_basicWebServer.sh
# ./0a1b_basicWebServer.sh
<<comment
* TITLE:  0a1b_basicWebServer.sh
* AUTHOR: Lance Pierson
* EMAIL:  info@treyark.com
* DATE:   2/14/23
* EXECUTIVE SUMMARY: 
* UNIT TEST RESULT: 
comment
echo "The script is live!"

#Call your vArs!
yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)

sleep 1
echo ""
echo "The following script installs an Apache webserver, a UFW Firewall, opens the necessary WWW ports"
echo "& installs Certbot a SSL Certificate generator."
echo ""
sleep 2
echo ""
echo "Installing Uncomplicated Firewall, this may already be installed..."
sudo apt install ufw -y
sleep 1
echo " "
echo "Allow WWW ports 443 and 80"
sudo ufw allow in "WWW Full"
sleep 1
echo " "
echo "Check UFW Status:"
sudo ufw status
sleep 1
echo " "
echo "Installing Apache Webserver..."
sudo apt install apache2 -y
sleep 1
echo " "
echo "Installing dependencies for certbot"
sleep 1
echo ""
echo "+ Snap D"
sudo apt install snapd
sleep 1
echo " "
echo "+ Snap Core"
sudo snap install core
sleep 1
echo " "
echo "Refresh Snap Core"
sudo snap refresh core
sleep 1
echo " "
echo "Installing Certbot"
sudo snap install --classic certbot
sleep 1
echo " "
echo "Adding symbolic link for Certbot"
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sleep 1
echo "Installing apache pligin..."
sudo service apache2 reload
sudo apt install python3-certbot-apache -y
echo "The script has concluded. Bye"
sh /etc/springb0ard/programFiles/0a1c_configBasicWebServer.sh
