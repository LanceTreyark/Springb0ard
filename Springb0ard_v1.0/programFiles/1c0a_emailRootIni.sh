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
# add curl scripts to be placed into programFiles then make the m executable
# add echo at the top of each script to identify what stage of execution we are in ie 1/6, 2/6, 5/6 etc..
# add commands at the bottom of each script to move on to the next script
# remove any "press enter to continue things that will hault the script more than neccessary"
# 
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
sleep 1
echo "Updating the server..."
read -p "Press enter to proceed" vArx
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
read -p "Create a non-root 'sudo user'. What would you like to set as the new username?:  " sudoUser
echo "Creating new user, you will need to create password for this"






adduser $sudoUser
sleep 1
echo "Adding new user to sudo group"
sleep 1
usermod -aG sudo $sudoUser
sudoUserID=$(id -u $sudoUser)
echo "Installing dependencies"
sleep 1
echo "Installing Curl"
sleep 1
sudo apt install curl -y
sleep 1
mkdir /home/$sudoUser/vArs 
echo "$sudoUser" >> /etc/springb0ard/vArs/sudoUser.txt
echo "$webAdminEmail" >> /etc/springb0ard/vArs/webAdminEmail.txt




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
cat /home/$sudoUser/.ssh/authorized_keys
sleep 1
echo "Create basic Alias commands to run updates in /home/$sudoUser/ directory"
cat >/home/$sudoUser/.bash_aliases <<EOF
alias hi="sudo apt update && sudo apt upgrade"
alias deploy="sh /etc/
EOF
sleep 1
echo "Enable the Alias file"
sudo chmod +x /home/$sudoUser/.bash_aliases
sudo chmod +x /etc/springb0ard/vArs/programFiles/0a3a_installPostfix.sh
sudo chmod +x
sudo chmod +x
sudo chmod +x
sudo chmod +x
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/vArs
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases
echo "This script has concluded"
sleep 1


