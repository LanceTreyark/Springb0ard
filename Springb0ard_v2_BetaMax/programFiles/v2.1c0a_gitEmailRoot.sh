#!/bin/bash
# nano v2.1b0a_emailRootIni.sh
# sudo chmod +x v2.1b0a_emailRootIni.sh
# ./v2.1b0a_emailRootIni.sh
echo "The Script is Live"
#Call your vArs!
# yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/mailDomain.txt)
# mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/mailDomain.txt)
# regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/regMailUser.txt)
# sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/sudoUser.txt)
# sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/sudoUserID.txt)
# myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/myIP.txt)
# webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/webAdminEmail.txt)
# webDomainName=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/mailDomain.txt)
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
#
# TODO:
<<comment
# For every new script added to the repo after the inital install they will need installers that make them executable
# and add aliases to whatever needs it
comment
#
echo "Updating the server..."
sudo timedatectl set-timezone America/Los_Angeles
sudo apt update && sudo apt upgrade -y
sudo apt install snapd -y
sudo snap install core
sudo snap install btop
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
mkdir /tmp/vArs
echo "$sudoUser" > /tmp/vArs/sudoUser.txt
echo "$sudoUserID" > /tmp/vArs/sudoUserID.txt
echo "$webAdminEmail" > /tmp/vArs/webAdminEmail.txt
echo "$regMailUser" > /tmp/vArs/regMailUser.txt
echo "$mailDomain" > /tmp/vArs/mailDomain.txt
echo "$myIP" > /tmp/vArs/myIP.txt
#sudo cp -a /tmp/vArs/. /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/
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
alias deploy="/etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh"
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
echo "Installing Git core update system"
echo "Creating springb0ard directory through git core system"
mkdir /tmp/git
curl -o /tmp/git/git.tar.gz "https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.40.0.tar.gz"
cd /tmp/git && tar -xf git.tar.gz && rm -r git.tar.gz && cd -
sudo mkdir /etc/springb0ard ################################################
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
cp -r /tmp/git /etc/springb0ard/
echo "install aspell"
sudo apt install aspell -y 
sleep 1
echo "sudo apt install libcurl4-openssl-dev -y"
sudo apt install libcurl4-openssl-dev -y
echo "sudo apt install libexpat1-dev -y"
sudo apt install libexpat1-dev -y
echo "sudo apt install gettext tcl -y"
sudo apt install gettext tcl -y
echo "sudo apt install make -y"
sudo apt install make -y
echo "sudo apt install gcc -y"
sudo apt install gcc -y
echo "sudo apt install libssl-dev -y"
sudo apt install libssl-dev -y
echo "sudo apt install zlib1g-dev -y"
sudo apt install zlib1g-dev -y
cd /etc/springb0ard/git/git-2.40.0
pwd
echo "sudo make prefix=/usr/local all" 
sudo make prefix=/usr/local all
echo "sudo make prefix=/usr/local install"
sudo make prefix=/usr/local install
sleep 1
echo "git --version"
git --version
cd /etc/springb0ard/
git clone https://github.com/LanceTreyark/Springb0ard.git
echo "Making springboard executable..."
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
echo "Adding stored variables to springb0ard directory..."
sudo cp -a /tmp/vArs/. /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/
echo "This script has concluded"
sleep 1
echo "Switching to $sudoUser"
echo "Type the command 'deploy' to continue with the installation"
sleep 1
su $sudoUser