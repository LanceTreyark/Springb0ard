#!/bin/bash
# nano v2.1b0a_minorRootIni.sh
# sudo chmod +x v2.1b0a_minorRootIni.sh
# ./v2.1b0a_minorRootIni.sh

echo "The Script is Live"
echo ""
echo "This script does the following:"
echo "1-Updates and upgrades the Debian Operating System"
echo "2-Creates a new sudo user for the server"
echo "3-Installs & enables the UFW firewall"
echo "4-Copies over the ssh-keys to the new user"
echo ""
read -p "Press enter if you are ready to proceed" meh
echo ""
sleep 1
echo "Updating the server..."
echo ""
sudo apt update && sudo apt upgrade -y
echo ""
read -p "Create a non-root 'sudo user'. What would you like to set as the new username?:  " sudoUser
echo ""
echo "Creating new user, you will need to create password for this"
adduser $sudoUser
echo "Adding new user to sudo group"
usermod -aG sudo $sudoUser
sudoUserID=$(id -u $sudoUser)
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
echo "This script has concluded"


