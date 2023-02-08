#!/bin/bash
#nano 1a0a_RootIni.sh
#sudo chmod +x 1a0a_RootIni.sh
# UNIT TEST NUMBER: 020823_1
# TEST RESULT:
# STATE ISSUES:
<<comment
* TITLE:  1a0a_RootIni.sh
* AUTHOR: Lance Pierson
* EMAIL:  info@treyark.com
* DATE:   2/5/23
* EXECUTIVE SUMMARY: Root Initiaization Script
-Process:
1 create non sudo user
2 copy keys to that user 
3 curl phase zero, one, two -v.1.0 -Create a new public directory called experimental
4 Set up UFW
5 print all variables to text files in tmp and give ownership to $nonRootUsrName
comment
echo "The Script is Live"
sleep 1
echo "Updating the server..."
sleep 1
sudo apt update && sudo apt upgrade -y
sudo apt install snapd -y
sudo snap install core
sudo snap install btop
sleep 1
read -p "Create a non-root user. What would you like to set as the new username?:  " nonRootUsrName
read -p "Enter a hostname you want to use for this server:  " myHostname
# read -p "Choose a file name for your first auto repo:  " autoRepo1 ## DEPRECIATED
read -p "What is the remote origin for this new repository?   " gitOrigin1
read -p "What is your Git user email?  " gitEmail 
read -p "What is your Git user name?  " gitName   
read -p "EMAIL STUFF  " EMAIL_VARIABLES # ADD !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# read -p "Enter a file name for your Git repository root folder (or press enter for default 'gitRepo'): " GitRepoName # AUTOMATIC

GitRepoName="gitRepo"

# make txt files:
#touch /tmp/Springb0ard_v1.0/vArs/varAutoRepo1.txt # DEPRECIATED
#echo "$autoRepo1" >> /tmp/Springb0ard_v1.0/vArs/varAutoRepo1.txt # DEPRECIATED
touch /tmp/Springb0ard_v1.0/vArs/varGitOrigin1.txt
echo "$gitOrigin1" >> /tmp/Springb0ard_v1.0/vArs/varGitOrigin1.txt
touch /tmp/Springb0ard_v1.0/vArs/varGitEmail.txt
echo "$gitEmail" >> /tmp/Springb0ard_v1.0/vArs/varGitEmail.txt
touch /tmp/Springb0ard_v1.0/vArs/varGitName.txt
echo "$gitName" >> /tmp/Springb0ard_v1.0/vArs/varGitName.txt
touch /tmp/Springb0ard_v1.0/vArs/varGitRepoName.txt
echo "$GitRepoName" >> /tmp/Springb0ard_v1.0/vArs/varGitRepoName.txt
touch /tmp/Springb0ard_v1.0/vArs/varnonRootUsrName.txt
echo "$nonRootUsrName" >> /tmp/Springb0ard_v1.0/vArs/varnonRootUsrName.txt
sleep 1
echo "Creating new user, you will need to create password for this"
adduser $nonRootUsrName
sleep 1
echo "Adding new user to sudo group"
sleep 1
usermod -aG sudo $nonRootUsrName
echo "Installing dependencies"
sleep 1
echo "Installing Curl"
sleep 1
sudo apt install curl -y
sleep 1
echo "getting scripts ready for hand off"
mkdir /tmp/Springb0ard_v1.0
mkdir /tmp/Springb0ard_v1.0/vArs
mkdir /tmp/Springb0ard_v1.0/programFiles
mkdir /tmp/Springb0ard_v1.0/exampleDir
cd /tmp/Springb0ard_v1.0/exampleDir 
curl -o /tmp/Springb0ard_v1.0/exampleDir/Q_Com.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/Q_Com.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/exampleDir/Q_Com_v0.0.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/Q_Com_v0.0.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/exampleDir/microInit_i1.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/microInit_i1.sh"
ls -n 
curl -o /tmp/Springb0ard_v1.0/exampleDir/microInit_v0.0.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/microInit_v0.0.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a1a_sudoUsrIni.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1a_sudoUsrIni.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a2a_gitInstall.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2a_gitInstall.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a2b_gitConfigure.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2b_gitConfigure.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a2d_gitRootAlias.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2d_gitRootAlias.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a3a_installPostfix.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3a_installPostfix.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a3b_setCrontab.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3b_setCrontab.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a4a_configPostfix.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a4a_configPostfix.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a5a_configDovecot.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a5a_configDovecot.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a5b_Automation.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a5b_Automation.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a5c_x.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a5c_x.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a6a_allAlias.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6a_allAlias.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a6b_x.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6b_x.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a6c_x.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6c_x.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/0a6d_x.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6d_x.sh"
ls -n
curl -o /tmp/Springb0ard_v1.0/programFiles/1a0a_RootIni.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/1a0a_RootIni.sh"
ls -n
echo "Move scripts to /etc directory"
sudo mv /tmp/Springb0ard_v1.0/ /etc/
echo "setting ownership of program files to $nonRootUsrName"
sudo chown -R 1000:1000 /etc/Springb0ard_v1.0
sleep 1
echo "Making Scripts Executable"
sleep 1
sudo chmod +x /etc/Springb0ard_v1.0/exampleDir/Q_Com.sh
sudo chmod +x /etc/Springb0ard_v1.0/exampleDir/Q_Com_v0.0.sh
sudo chmod +x /etc/Springb0ard_v1.0/exampleDir/microInit_i1.sh
sudo chmod +x /etc/Springb0ard_v1.0/exampleDir/microInit_v0.0.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a1a_sudoUsrIni.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a2a_gitInstall.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a2b_gitConfigure.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a2d_gitRootAlias.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a3a_installPostfix.sh 
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a3b_setCrontab.sh 
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a4a_configPostfix.sh 
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a5a_configDovecot.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a5b_Automation.sh 
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a5c_x.sh 
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a6a_allAlias.sh 
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a6b_x.sh 
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a6c_x.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/0a6d_x.sh
sudo chmod +x /etc/Springb0ard_v1.0/programFiles/1a0a_RootIni.sh
cd - 
sleep 1
echo "Installing Firewall"
apt install ufw -y
sleep 1
echo "Allow SSH through the firewall"
ufw allow OpenSSH
sudo ufw enable
sleep 1
sudo ufw status
sleep 1
echo "Copy authorized_keys over to $nonRootUsrName"
sleep 1
echo "/home/$nonRootUsrName/.ssh/"
adminPubKeyString=$(cat .ssh/authorized_keys)
mkdir -p /home/$nonRootUsrName/.ssh
ls /home/$nonRootUsrName/.ssh/
sleep 1
echo $adminPubKeyString >> /home/$nonRootUsrName/.ssh/authorized_keys
sleep 1
ls /home/$nonRootUsrName/.ssh/
sleep 1
cat /home/$nonRootUsrName/.ssh/authorized_keys
sleep 1
echo "Create Alias commands to run scripts in /home/$nonRootUsrName/ directory"
cat >/home/$nonRootUsrName/.bash_aliases <<EOF
alias hi="sudo apt update && sudo apt upgrade"
alias go=". /etc/Springb0ard_v1.0/programFiles/0a1a_sudoUsrIni.sh"
EOF
sleep 1
echo "Enable the Alias file"
sudo chmod +x /home/$nonRootUsrName/.bash_aliases
echo "Assigning the HostName to the server"
sudo hostname $myHostName
hostName=$(hostname)
echo "The Hostname for this server is set to $hostName"
# Assign IP to variable:
myIPv4=$(ip addr show | awk '{if (match($2,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)) {print $2}}' | head -2 | tail -1)
cat >/tmp/ipSort3r.txt <<EOF
$myIPv4
EOF
myIP=$(awk -F/ '{print $1}' /tmp/ipSort3r.txt) 
sudo rm -r /tmp/ipSort3r.txt
echo "The IP address for this server is: $myIP"
# Add Host data to the end of hosts file:
sudo echo "$myIP $hostName" >> /etc/hosts    
echo "Switching over to $nonRootUsrName to complete the installations"
sleep 1
echo "Press Enter to continue..."
read -s -p ""
su $nonRootUsrName

