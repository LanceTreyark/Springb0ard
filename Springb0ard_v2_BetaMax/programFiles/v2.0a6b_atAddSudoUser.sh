#!/bin/bash
#
#                           Purpose add new sudo user and copy ssh keys to user
#
# nano v2.0a6b_atAddSudoUser.sh
# sudo chmod +x v2.0a6b_atAddSudoUser.sh
# ./v2.0a6b_atAddSudoUser.sh
echo "The Script is Live"
sleep 1
echo ""
echo "This script does the following:"
echo "1. Create a new user"
echo "2. Grant user root privileges by adding to sudo group"
echo "3. Copy ssh keys to new user so you can ssh into it directly"
echo "4. Copy over your current Alias Commands to new user"
echo "5. Grant ownership of the new ssh and alias files"
read -p "Press enter to begin" meh
cd ~/
aliasCommands=$(cat .bash_aliases)
read -p "Creating a new user with root privilages aka 'sudo user'. What would you like to set as the new username?:  " sudoUser
#sudoUser="cornelius"
echo ""
echo "Creating new user, you will need to create password for this"
sudo adduser $sudoUser
echo "Adding new user to sudo group"
sudo usermod -aG sudo $sudoUser
sudoUserID=$(id -u $sudoUser)
echo "Copy authorized_keys over to $sudoUser"
echo "/home/$sudoUser/.ssh/"
adminPubKeyString=$(cat .ssh/authorized_keys)
mkdir -p /home/$sudoUser/.ssh
ls /home/$sudoUser/.ssh/
echo $adminPubKeyString >> /home/$sudoUser/.ssh/authorized_keys
ls /home/$sudoUser/.ssh/
echo "Copy Alias commands to new user"
cat >/home/$sudoUser/.bash_aliases <<EOF
$aliasCommands
EOF
echo "Enable the Alias file"
sudo chmod +x /home/$sudoUser/.bash_aliases
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases
read -p "The script has concluded, press enter to switch to the new user" meh
su $sudoUser