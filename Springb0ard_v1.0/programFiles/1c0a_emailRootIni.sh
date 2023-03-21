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

# List every raw script addr in the suite:
# programFiles:
<<comment
example:
curl -o /tmp/Springb0ard_v1.0/exampleDir/Q_Com.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/Q_Com.sh"

# The idea is to build/curl everything we need into the tmp dir into the file that we will place into etc then assign ownership to sudo user 
final destination: /etc/springb0ard/
curl -o /tmp/springb0ard/exampleDir/Q_Com.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/Q_Com.sh"



For Beta Maxx:
mkdir -p /tmp/springb0ard/programFiles
mkdir  /tmp/springb0ard/vArs
mkdir  /tmp/springb0ard/exampleDir

curl -o /tmp/springb0ard/programFiles/0a1a_sudoUsrIni.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1a_sudoUsrIni.sh"
curl -o /tmp/springb0ard/programFiles/0a1b_basicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1b_basicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/0a1c_configBasicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1c_configBasicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1d_deploySimpleLandingPage.sh"
curl -o /tmp/springb0ard/programFiles/0a3a_installPostfix.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3a_installPostfix.sh"
curl -o /tmp/springb0ard/programFiles/0a3aa_Postfix.DKIM.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3aa_Postfix.DKIM.sh"



===end

https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1a_sudoUsrIni.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1b_basicWebServer.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1c_configBasicWebServer.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1d_deploySimpleLandingPage.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2a_gitInstall.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2b_gitConfigure.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a2d_gitRootAlias.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3a_installPostfix.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3aa_Postfix.DKIM.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3b_setCrontab.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a4a_configPostfix.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a5a_configDovecot.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a5b_Automation.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a5c_x.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6a_allAlias.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6b_x.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6c_x.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a6d_x.sh #unUsed
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/1a0a_RootIni.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/1b0a_minorRootIni.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/1c0a_emailRootIni.sh
comment
# exampleDir  Used for git
<<comment
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/Q_Com.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/Q_Com_v0.0.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/microInit_i1.sh
https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/exampleDir/microInit_v0.0.sh
comment






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
#read -p "Press enter to proceed" vArx
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




# List every variable in the suite:
#   1a0a:
#$gitOrigin1
#$gitEmail
#$gitName
#$GitRepoName
#$nonRootUsrName # replace this with $sudoUser
#$myHostname #unwritten

#   1c0a:
#$myIP
#$sudoUser
#$webAdminEmail
#$mailDomain
#$regMailUser
#yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
#mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
#regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
#sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
#myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
#webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)

#   0a1c:
# webDomainName=$(cat /etc/springb0ard/vArs/mailDomain.txt)


# added \/ 3.21.23
# Assign IP to variable:
myIPv4=$(ip addr show | awk '{if (match($2,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)) {print $2}}' | head -2 | tail -1)
cat >/tmp/ipSort3r.txt <<EOF
$myIPv4
EOF
myIP=$(awk -F/ '{print $1}' /tmp/ipSort3r.txt) 
echo "The IP address for this server is: $myIP"
#save IP as a hard variable 
#echo "$myIP" >> /tmp/springb0ard/vArs/myIP.txt
# removing tmp file
sudo rm -r /tmp/ipSort3r.txt
# added /\ 3.21.23


sleep 1
read -p "Creating a new user with root privilages aka 'sudo user'. What would you like to set as the new username?:  " sudoUser
echo ""

read -p "Enter your Administrative email to use for SSL Certification:   " webAdminEmail
echo ""

read -p "Please enter the domain name to use for this mailserver, Don't add the 'www., mail. or smtp.' just the domain:   " mailDomain
echo ""

read -p "Please create a new username for your new virtual inbound email address:   " regMailUser
echo ""

read -p ""
echo ""

read -p ""
echo ""

read -p ""
echo ""

read -p ""
echo ""





# hard code every variable right now to the tmp file
# use the single > symbol for vArs so if they change the new value will overwrite 
# the old value rather than appending an additional value to the file.
echo "$sudoUser" > /tmp/springb0ard/vArs/sudoUser.txt
echo "$webAdminEmail" > /tmp/springb0ard/vArs/webAdminEmail.txt
echo "$regMailUser" > /etc/springb0ard/vArs/regMailUser.txt
echo "$mailDomain" > /etc/springb0ard/vArs/mailDomain.txt
echo "$myIP" > /tmp/springb0ard/vArs/myIP.txt









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


# \/ This creates a variable to hold the specified users id # ie 1001
sudoUserID=$(id -u $sudoUser)

sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/vArs
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases





echo "Installing Springb0ard"
curl -o /tmp/springb0ard/programFiles/0a1a_sudoUsrIni.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1a_sudoUsrIni.sh"
curl -o /tmp/springb0ard/programFiles/0a1b_basicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1b_basicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/0a1c_configBasicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1c_configBasicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a1d_deploySimpleLandingPage.sh"
curl -o /tmp/springb0ard/programFiles/0a3a_installPostfix.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3a_installPostfix.sh"
curl -o /tmp/springb0ard/programFiles/0a3aa_Postfix.DKIM.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v1.0/programFiles/0a3aa_Postfix.DKIM.sh"

sudo chmod +x /tmp/springb0ard/programFiles/0a1a_sudoUsrIni.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a1b_basicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a1c_configBasicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a3a_installPostfix.sh
sudo chmod +x /tmp/springb0ard/programFiles/0a3aa_Postfix.DKIM.sh



# after all variables are added & sudo user created move springboard and give ownership to sudo user 
# Give ownership of springb0ard to my regular user
#userID=$(id -u)
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard



echo "This script has concluded"
sleep 1


