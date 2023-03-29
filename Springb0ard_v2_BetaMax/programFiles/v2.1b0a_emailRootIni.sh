#!/bin/bash
# nano v2.1b0a_emailRootIni.sh
# sudo chmod +x v2.1b0a_emailRootIni.sh
# ./v2.1b0a_emailRootIni.sh
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
sleep 1
echo "Updating the server..."
sudo timedatectl set-timezone America/Los_Angeles
sleep 1
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
read -p "Creating a new user with root privilages aka 'sudo user'. What would you like to set as the new username?:  " sudoUser
#sudoUser="userName"
echo ""
read -p "Enter your Administrative email to use for SSL Certification:   " webAdminEmail
#webAdminEmail="name@example.com"
echo ""
read -p "Please enter the domain name to use for this mailserver, Don't add the 'www., mail. or smtp.' just the domain:   " mailDomain
#mailDomain="example.com"
echo ""
read -p "Please create a new username for your new virtual inbound email address:   " regMailUser
#regMailUser="admin"
echo ""
echo "Creating new user, you will need to create password for this"
adduser $sudoUser
sleep 1
echo "Adding new user to sudo group"
sleep 1
usermod -aG sudo $sudoUser
sudoUserID=$(id -u $sudoUser)
echo "$sudoUser" > /tmp/springb0ard/vArs/sudoUser.txt
echo "$sudoUserID" > /tmp/springb0ard/vArs/sudoUserID.txt
echo "$webAdminEmail" > /tmp/springb0ard/vArs/webAdminEmail.txt
echo "$regMailUser" > /tmp/springb0ard/vArs/regMailUser.txt
echo "$mailDomain" > /tmp/springb0ard/vArs/mailDomain.txt
echo "$myIP" > /tmp/springb0ard/vArs/myIP.txt
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
alias deploy="sh /etc/springb0ard/programFiles/v2.0a2a_installPostfix.sh"
alias bootmail="sudo systemctl restart dovecot && sudo systemctl restart postfix"
alias maillog="sudo nano /var/log/mail.log"
alias springb0ard="cat /home/$sudoUser/.bash_aliases"
alias springboard="cat /home/$sudoUser/.bash_aliases"
EOF
sleep 1
echo "Enable the Alias file"
sudo chmod +x /home/$sudoUser/.bash_aliases
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases
echo "Installing Springb0ard"
curl -o /tmp/springb0ard/programFiles/v2.0a1a_springb0ardManager.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a2a_installPostfix.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a2a_installPostfix.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a2b_Postfix.DKIM.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a2b_Postfix.DKIM.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a3a_basicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_basicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a3b_configBasicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a3b_configBasicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a3c_deploySimpleLandingPage.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a3c_deploySimpleLandingPage.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a4a_addScp3r.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh"
#  #  #   These \/ will be installed when this test /\ is executed
#curl -o /tmp/springb0ard/programFiles/v2.0a4b_Scp3r.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh"
#curl -o /tmp/springb0ard/programFiles/v2.0a4c_qscp.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh"
#  #  #
#curl -o /tmp/springb0ard/programFiles/NAME_HERE "URL_HERE" 
# sudo chmod +x
#  #  #
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a1a_springb0ardManager.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a2a_installPostfix.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a3a_basicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a3b_configBasicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a3c_deploySimpleLandingPage.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a2b_Postfix.DKIM.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a4a_addScp3r.sh # aliases have not been created for these yet \/
#  #  #  These \/ will be installed when this test /\ is executed 
#sudo chmod +x /tmp/springb0ard/programFiles/v2.0a4b_Scp3r.sh
#sudo chmod +x /tmp/springb0ard/programFiles/v2.0a4c_qscp.sh
#  #  #
sudo cp -r /tmp/springb0ard /etc/
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
echo "This script has concluded"
sleep 1
echo "Switching to $sudoUser"
echo "Type the command 'deploy' to continue with the installation"
sleep 1
su $sudoUser



# TODO:
<<comment
Add aliases to the script that need them

Add git as a core component

For every new script added to the repo aver the inital install they will need installers that make them executable
 and add aliases to whatever needs it
comment