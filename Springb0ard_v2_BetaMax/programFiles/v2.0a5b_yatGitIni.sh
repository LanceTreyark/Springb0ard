#!/bin/bash
# nano v2.0a5b_yatGitIni.sh
# sudo chmod +x v2.0a5b_yatGitIni.sh
# ./v2.0a5b_yatGitIni.sh
#Call your vArs!
yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/vArs/mailDomain.txt)
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
echo "Checking for SSH keys..."
#####
# check the server for an ssh key, if one does not exist offer to make one
# ask user if the key has been added to your SCP destinations authorized users file.
#-----------------------------------------------------------------------------
if [ -f /home/$sudoUser/.ssh/id_rsa.pub ]; then
    cat /home/$sudoUser/.ssh/id_rsa.pub
    read -p "Have you added this key to to your destinations authorized_users file or git settings? (Y/N) " response
    if [ "$response" = "n" ]; then
        echo "Please add this key to your destinations authorized_users file, or git settings."
    fi
else
    read -p "It appears that an ssh key has not been generated. Would you like to create one? (Y/N) " response
    if [ "$response" = "y" ]; then
        ssh-keygen
        echo ""
        cat /home/$sudoUser/.ssh/id_rsa.pub
        echo ""
        echo "Please add this key to your destinations authorized_users file or git settings."
        echo ""
    else
        echo "If you don't add the ssh-key the SSH communication will fail. Are you shure you want to skip this?"
        read -p "Enter (Y/N): " choice
        if [ "$choice" = "n" ]; then
            ssh-keygen
            cat /home/$sudoUser/.ssh/id_rsa.pub
            echo "Please add this key your destinations authorized_users file or git settings."
        fi
    fi
fi
#####
cd /etc/springb0ard/git/
git clone https://github.com/LanceTreyark/Springb0ard.git

echo "The script has concluded"