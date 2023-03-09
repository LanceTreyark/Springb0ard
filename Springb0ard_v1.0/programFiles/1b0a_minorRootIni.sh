#!/bin/bash
#nano 1b0a_minorRootIni.sh
#sudo chmod +x 1b0a_minorRootIni.sh
# UNIT TEST NUMBER: 020823_1
# TEST RESULT:
# STATE ISSUES:



#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



<<comment
* TITLE:  1a0a_RootIni.sh
* AUTHOR: Lance Pierson
* EMAIL:  info@treyark.com
* DATE:   2/5/23
* EXECUTIVE SUMMARY: Minor Root Initiaization Script
-Purpose
1 This script sets up the most basic core configurations for a new server, It assumes nothing
  other than secure loging using ssh keys and a sudo user rather than using root user.
-Scope:
1 create non sudo user
2 copy keys to that user 
3 Set up curl, btop & snap
4 Set up UFW and open 22
5 print all variables to text files in sudo user home ~/ and give ownership to $sudoUser
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
read -p "Create a non-root "sudo user". What would you like to set as the new username?:  " sudoUser
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
echo "$sudoUser" >> /home/$sudoUser/vArs/varsudoUser.txt
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
EOF
sleep 1
echo "Enable the Alias file"
sudo chmod +x /home/$sudoUser/.bash_aliases
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/vArs
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases
echo "This script has concluded"
sleep 1


