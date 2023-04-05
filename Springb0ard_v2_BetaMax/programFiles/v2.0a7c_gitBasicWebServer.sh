#!/bin/bash
# nano v2.0a3a_basicWebServer.sh
# sudo chmod +x v2.0a3a_basicWebServer.sh
# ./v2.0a3a_basicWebServer.sh
echo "The script is live!"
#Call your vArs!
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
echo ""
echo "The following script installs an Apache webserver, a UFW Firewall, opens the necessary WWW ports"
echo "& installs Certbot a SSL Certificate generator."
echo ""
echo ""
echo "Installing Uncomplicated Firewall, this may already be installed..."
sudo apt install ufw -y
echo " "
echo "Allow WWW ports 443 and 80"
sudo ufw allow in "WWW Full"
echo " "
echo "Check UFW Status:"
sudo ufw status
echo " "
echo "Installing Apache Webserver..."
sudo apt install apache2 -y
echo " "
echo "Installing dependencies for certbot"
echo ""
echo "+ Snap D"
sudo apt install snapd
echo " "
echo "+ Snap Core"
sudo snap install core
echo " "
echo "Refresh Snap Core"
sudo snap refresh core
echo " "
echo "Installing Certbot"
sudo snap install --classic certbot
echo " "
echo "Adding symbolic link for Certbot"
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo "Installing apache plugin..."
sudo service apache2 reload
sudo apt install python3-certbot-apache -y
echo "Preparing to start Webserver Configuration..."
echo "sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh"
sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh