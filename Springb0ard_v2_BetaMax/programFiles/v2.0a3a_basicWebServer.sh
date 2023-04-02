#!/bin/bash
# nano v2.0a3a_basicWebServer.sh
# sudo chmod +x v2.0a3a_basicWebServer.sh
# ./v2.0a3a_basicWebServer.sh
echo "The script is live!"
#Call your vArs!
yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
defaultScpAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
scpExportPath=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt)
echo "           vArs Test:"
echo "-----------------------------"
echo "yourDomain=$yourDomain"
echo "mailDomain=$mailDomain"
echo "regMailUser=$regMailUser"
echo "sudoUser=$sudoUser"
echo "sudoUserID=$sudoUserID"
echo "myIP=$myIP"
echo "webAdminEmail=$webAdminEmail"
echo "webDomainName=$webDomainName"
echo "defaultScpAddr=$defaultScpAddr"
echo "scpExportPath=$scpExportPath"
echo "-----------------------------"
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
echo "Installing apache plugin..."
sudo service apache2 reload
sudo apt install python3-certbot-apache -y
echo "Next,"
echo "sh /etc/springb0ard/programFiles/v2.0a3b_configBasicWebServer.sh"
sh /etc/springb0ard/programFiles/v2.0a3b_configBasicWebServer.sh