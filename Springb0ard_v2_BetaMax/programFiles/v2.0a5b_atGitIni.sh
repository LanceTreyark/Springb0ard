#!/bin/bash
# nano v2.0a5b_atGitIni.sh
# sudo chmod +x v2.0a5b_atGitIni.sh
# ./v2.0a5b_atGitIni.sh
#Call your vArs!
yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
defaultScpAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
scpExportPath=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt)
echo "           vArs Test:"
echo "-----------------------------"
echo "yourDomain=$yourDomain"
echo "mailDomain=$mailDomain"
echo "regMailUser=$regMailUser"
echo "sudoUser=$sudoUser"
echo "sudoUserID=$sudoUserID"
echo "myIP=$myIP"
echo "webAdminEmail=$webAdminEmail"
echo "webDomainName=$webDomainName"
echo "defaultScpAddr=$defaultScpAddr"
echo "scpExportPath=$scpExportPath"
echo "-----------------------------"
#
echo "The script is live "
echo "git installer, begin"
echo "installing dependencies"
echo "Verify 'curl' is installed"
sudo apt install curl -y
echo "Adding git to the springb0ard directory"
mkdir /tmp/git
#curl -o /tmp/git/git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.39.0.tar.gz //OLD
curl -o /tmp/git/git.tar.gz "https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.40.0.tar.gz"
cd /tmp/git && tar -xf git.tar.gz && rm -r git.tar.gz && cd -
# It is assumed the directory is made and permission is that of the sudo user
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
echo "End of script."
sleep 1
echo "git install phase completed"
echo ""
#####
#KeyGen deleted
#####
cd /etc/springb0ard/git/
git clone https://github.com/LanceTreyark/Springb0ard.git
# git pull
echo "The script has concluded"