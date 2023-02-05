#!/bin/bash

# ON 1/31/23 THIS SCRIPT WAS SUPERSEDED BY: C:\Users\treya\Desktop\GitHubRepo\0012_UnitTesting\013023_SpringBoard_i1\0_rootInit.shS
# Was PhaseZeroZeroUnitTest.sh
# Server Initialization Phase
<<comment
Process:
1) create non sudo user
2) copy keys to that user 
3) curl phase zero, one, two -v.1.0 -Create a new public directory called experimental
4) Set up UFW
5) print all variables to text files in tmp and give ownership to $nonRootUsrName
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
# The variables below need to be hard written outside this script as txt files in /tmp so they can be called into the other scripts
read -p "Choose a file name for your first auto repo:  " autoRepo1
read -p "What is the remote origin for this new repository?   " gitOrigin1
read -p "What is your Git user email?  " gitEmail 
read -p "What is your Git user name?  " gitName   
read -p "Enter a file name for your Git repository root folder (or press enter for default 'gitRepo'): " GitRepoName
# make txt files:
mkdir /tmp/vArs
#1
touch /tmp/vArs/varAutoRepo1.txt
echo "$autoRepo1" >> /tmp/vArs/varAutoRepo1.txt
#2
touch /tmp/vArs/varGitOrigin1.txt
echo "$gitOrigin1" >> /tmp/vArs/varGitOrigin1.txt
#3
touch /tmp/vArs/varGitEmail.txt
echo "$gitEmail" >> /tmp/vArs/varGitEmail.txt
#4
touch /tmp/vArs/varGitName.txt
echo "$gitName" >> /tmp/vArs/varGitName.txt
#5
touch /tmp/vArs/varGitRepoName.txt
echo "$GitRepoName" >> /tmp/vArs/varGitRepoName.txt
#6
touch /tmp/vArs/varnonRootUsrName.txt
echo "$nonRootUsrName" >> /tmp/vArs/varnonRootUsrName.txt
#
sleep 1
echo "Creating new user"
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
mkdir /tmp/iniScripts
sleep 1
curl -o /tmp/iniScripts/PhaseOneUnitTest.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/posOne.sh
sleep 1
curl -o /tmp/iniScripts/PhaseTwoUnitTest.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/posTwo.sh
sleep 1
#curl -o /tmp/iniScripts/x https://url
#sleep 1
#
echo "Move scripts to $nonRootUsrName's home directory"
sudo mv /tmp/iniScripts /home/$nonRootUsrName/
sleep 1
echo "Making Scripts Executable"
sleep 1
sudo chmod +x /home/$nonRootUsrName/iniScripts/PhaseOneUnitTest.sh
sudo chmod +x /home/$nonRootUsrName/iniScripts/PhaseTwoUnitTest.sh
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
alias goOne=". /home/$nonRootUsrName/iniScripts/PhaseOneUnitTest.sh"
alias goTwo=". /home/$nonRootUsrName/iniScripts/PhaseTwoUnitTest.sh"
EOF
sleep 1
echo "Enable the Alias file"
sudo chmod +x /home/$nonRootUsrName/.bash_aliases

# PhaseZeroUnitTest.sh
# Server Initialization Phase Zero
<<comment
TODO:
0) DONE ! ZeroZero PreScript -Setup new user
1) DONE ! Add your keys to a new non root user authorized users file
2) DONE (in githubScript) ! Once you are using non root user you need to create ssh keys and display them & prompt the user to copy and paste them into github.
3) DONE ! save the server IP to a variable called $myIP
4) DONE ! Set the hostname, save the hostname to a variable called $myHostName
# Pick up your trash tmp files!
comment
#
# Set Hostname & Assign to a variable:
#read -p "Enter a hostname you want to use for this server:  " $myHostname #Moved to top of page
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
#
echo "Setting Alias commands for current session..."
sleep 1
alias hi="sudo apt update && sudo apt upgrade"
alias goOne=". /home/$nonRootUsrName/iniScripts/PhaseOneUnitTest.sh"
alias goTwo=". /home/$nonRootUsrName/iniScripts/PhaseTwoUnitTest.sh"
#
echo "Switching over to $nonRootUsrName to complete the installations"
sleep 1
su $nonRootUsrName

