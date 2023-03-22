#!/bin/bash
# nano 1c0a_emailRootIni.sh
# sudo chmod +x 1c0a_emailRootIni.sh
# ./1c0a_emailRootIni.sh
# UNIT TEST NUMBER: 020823_1
# TEST RESULT:
# STATE ISSUES:



#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




#TODO
# make sure all the aliases we need are declared and saved here
# make sure all the variables we need are declared and saved here
# add curl scripts to be placed into programFiles then make the m executable
# add echo at the top of each script to identify what stage of execution we are in ie 1/6, 2/6, 5/6 etc..
# add commands at the bottom of each script to move on to the next script
# remove any "press enter to continue things that will hault the script more than neccessary"
# 

<<comment
* TITLE:  1c0a_emailRootIni.sh
* AUTHOR: Lance Pierson
* EMAIL:  info@treyark.com
* DATE:   2/5/23
* EXECUTIVE SUMMARY: Email Root Initiaization Script
-Purpose
This script fast tracks an email server deployment.
We ask all the questions here once then the server installs the required software and preconfigurations.
once the root is initialized we log into the sudo user and run an alias command "deploy"
comment
echo "The Script is Live"

#Call your vArs!
# yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
# mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
# regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
# sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
# sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
# myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
# webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)
# webDomainName=$(cat /etc/springb0ard/vArs/mailDomain.txt)

#echo "           vArs Test:"
#echo "-----------------------------"
#echo "yourDomain=$yourDomain"
#echo "mailDomain=$mailDomain"
#echo "regMailUser=$regMailUser"
#echo "sudoUser=$sudoUser"
#echo "sudoUserID=$sudoUserID"
#echo "myIP=$myIP"
#echo "webAdminEmail=$webAdminEmail"
#echo "webDomainName=$webDomainName"
#echo "-----------------------------"
#----------------------------------------------------
sleep 1
echo "Updating the server..."
sleep 1
echo "."
echo "."
sleep 1
echo ".."
echo ".."
sleep 1
echo "..."
echo "..."
sudo apt update && sudo apt upgrade -y
sudo apt install snapd -y
sudo snap install core
sudo snap install btop
sleep 1
echo "Creating Springb0ard Directory"
sleep 1
mkdir -p /tmp/springb0ard/programFiles
mkdir  /tmp/springb0ard/vArs
mkdir  /tmp/springb0ard/exampleDir
# IP -In #
myIPv4=$(ip addr show | awk '{if (match($2,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)) {print $2}}' | head -2 | tail -1)
cat >/tmp/ipSort3r.txt <<EOF
$myIPv4
EOF
myIP=$(awk -F/ '{print $1}' /tmp/ipSort3r.txt) 
echo "The IP address for this server is: $myIP"
sudo rm -r /tmp/ipSort3r.txt
# IP -Out #
sleep 1
#read -p "Creating a new user with root privilages aka 'sudo user'. What would you like to set as the new username?:  " sudoUser
sudoUser="spencer"
#echo ""
#read -p "Enter your Administrative email to use for SSL Certification:   " webAdminEmail
webAdminEmail="info@treyark.com"
#echo ""
#read -p "Please enter the domain name to use for this mailserver, Don't add the 'www., mail. or smtp.' just the domain:   " mailDomain
mailDomain="springb0ard.com"
#echo ""
#read -p "Please create a new username for your new virtual inbound email address:   " regMailUser
regMailUser="admin"
echo ""
echo "Creating new user, you will need to create password for this"
adduser $sudoUser
sleep 1
echo "Adding new user to sudo group"
sleep 1
usermod -aG sudo $sudoUser
sudoUserID=$(id -u $sudoUser)
#
echo "$sudoUser" > /tmp/springb0ard/vArs/sudoUser.txt
echo "$sudoUserID" > /tmp/springb0ard/vArs/sudoUserID.txt
echo "$webAdminEmail" > /tmp/springb0ard/vArs/webAdminEmail.txt
echo "$regMailUser" > /tmp/springb0ard/vArs/regMailUser.txt
echo "$mailDomain" > /tmp/springb0ard/vArs/mailDomain.txt
echo "$myIP" > /tmp/springb0ard/vArs/myIP.txt
#
echo "Installing dependencies"
sleep 1
echo "Installing Curl"
sleep 1
sudo apt install curl -y
sleep 1
echo "Installing Firewall"
apt install ufw -y
sleep 1
echo "Allow SSH through the firewall"
ufw allow OpenSSH
ufw enable
sleep 1
ufw status
sleep 1
echo "Copy authorized_keys over to $sudoUser"
sleep 1
echo "/home/$sudoUser/.ssh/"
adminPubKeyString=$(cat .ssh/authorized_keys)
mkdir -p /home/$sudoUser/.ssh
ls /home/$sudoUser/.ssh/
sleep 1
echo $adminPubKeyString >> /home/$sudoUser/.ssh/authorized_keys
sleep 1
ls /home/$sudoUser/.ssh/
sleep 1
#cat /home/$sudoUser/.ssh/authorized_keys
sleep 1
echo "Create basic Alias commands to run updates in /home/$sudoUser/ directory"
cat >/home/$sudoUser/.bash_aliases <<EOF
alias hi="sudo apt update && sudo apt upgrade"
alias deploy="sh /etc/springb0ard/programFiles/0a3a_installPostfix.sh"
EOF
sleep 1
echo "Enable the Alias file"
sudo chmod +x /home/$sudoUser/.bash_aliases
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases
echo "Installing Springb0ard"
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
curl -o /tmp/springb0ard/programFiles/0a1b_basicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1b_basicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/0a1c_configBasicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1c_configBasicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1d_deploySimpleLandingPage.sh"
curl -o /tmp/springb0ard/programFiles/0a3a_installPostfix.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3a_installPostfix.sh"
curl -o /tmp/springb0ard/programFiles/0a3aa_Postfix.DKIM.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3aa_Postfix.DKIM.sh"
sudo chmod +x /tmp/springb0ard/programFiles/0a3a_installPostfix.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a1b_basicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a1c_configBasicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a3aa_Postfix.DKIM.sh
# after all variables are added & sudo user created move springboard and give ownership to sudo user 
# Give ownership of springb0ard to my regular user
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
sudo cp -r /tmp/springb0ard /etc/
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
echo "This script has concluded"
sleep 1
echo "Switching to $sudoUser"
echo "after logging in type the command 'deploy' to continue with the installation"
sleep 1
read -p "Press enter when you are ready" meh
su $sudoUser