#!/bin/bash
# nano v2.0a5a_yatSpringboardIni.sh
# sudo chmod +x v2.0a5a_yatSpringboardIni.sh
# ./v2.0a5a_yatSpringboardIni.sh

# Installs Springboard Tools as options on an existing server
# these are the "yat" scripts they assume nothing other than the stated assumtions that are echoed at the top with a "press enter to proceed"

# Test if git is installed
# Test if postfix is installed
# Test if Dovecot it installed 

# Variable Declarations:
sudoUser=$(who am i | awk '{print $1}')
echo "It is assumed that the required sudo user to run this script is $sudoUser"
sudoUserID=$(id -u $sudoUser)


# PROBLEM What if the user wants to just add our tools like scp3r and they already have email working properly?
# Purpose of this is just the tools no installations.


if which postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'which' command)."
  postfixWhichTest="1"
else
  echo "Postfix is not installed (checked using 'which' command)."
  postfixWhichTest="0"
fi

if dpkg -s postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'dpkg' command)."
  postfixDpkgTest="1"
else
  echo "Postfix is not installed (checked using 'dpkg' command)."
  postfixDpkgTest="0" 
fi

if systemctl is-active --quiet postfix; then
  echo "Postfix is installed and active (checked using systemctl command)."
  postfixSystemctlTest="1"
else
  echo "Postfix is not installed or inactive (checked using systemctl command)."
  postfixSystemctlTest="0"
fi

if which dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'which' command)."
  dovecotWhichTest="1"
else
  echo "Dovecot is not installed (checked using 'which' command)."
  dovecotWhichTest="0"

fi

if dpkg -s dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'dpkg' command)."
  dovecotDpkgTest="1"
else
  echo "Dovecot is not installed (checked using 'dpkg' command)."
  dovecotDpkgTest="0"
fi

if systemctl is-active --quiet dovecot; then
  echo "Dovecot is installed and active (checked using systemctl command)."
  dovecotSystemctlTest="1"
else
  echo "Dovecot is not installed or inactive (checked using systemctl command)."
  dovecotSystemctlTest="0"
fi

if which git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'which' command)."
  gitWhichTest="1"
else
  echo "Git is not installed (checked using 'which' command)."
  gitWhichTest="0"
fi

if dpkg -s git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'dpkg' command)."
  gitDpkgTest="1"
else
  echo "Git is not installed (checked using 'dpkg' command)."
  gitDpkgTest="0"
fi

echo "postfixWhichTest=$postfixWhichTest"
echo "postfixDpkgTest=$postfixDpkgTest"
echo "postfixSystemctlTest=$postfixSystemctlTest"
echo "dovecotWhichTest=$dovecotWhichTest"
echo "dovecotDpkgTest=$dovecotDpkgTest"
echo "dovecotSystemctlTest=$dovecotSystemctlTest"
echo "gitWhichTest=$gitWhichTest"
echo "gitDpkgTest=$gitDpkgTest"


if [ $((postfixWhichTest + postfixDpkgTest + postfixSystemctlTest)) -ge 1 ]; then
  echo "Postfix is currently installed on this system"
  #echo "Removing previous Postfix installation ..."
  #sudo apt-get remove --purge postfix
  #sudo apt-get autoremove --purge
  #sudo apt-get clean
fi

if [ $((dovecotWhichTest + dovecotDpkgTest + dovecotSystemctlTest)) -ge 1 ]; then
  echo "Dovecot is currently installed on this system"
  #echo "Removing previous Dovecot installation..."
  #sudo apt-get remove --purge dovecot
  #sudo apt-get autoremove --purge
  #sudo apt-get clean
fi

if [ $((gitWhichTest + gitDpkgTest)) -eq 0 ]; then
  echo "Git was not detected on this system. We will need to install this core dependency"
  echo "Begin git core & Springb0ard install procedure..."
  echo "making sure the system is up to date..."
  sudo apt update && sudo apt upgrade -y
  echo "Installing dependencies, some of these may already exist on your system"
  sudo apt install snapd -y
  sudo snap install core
  sudo snap install btop
  echo "Installing Curl"
  sudo apt install curl -y
  read -p "Are you ready to proceed with the git install?" meh
  sleep 1
  echo ""
  echo "Installing Git, Springb0ard's core software updating system"
  mkdir /tmp/git
  curl -o /tmp/git/git.tar.gz "https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.40.0.tar.gz"
  cd /tmp/git && tar -xf git.tar.gz && rm -r git.tar.gz && cd -
  sudo mkdir /etc/springb0ard
  sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
  cp -r /tmp/git /etc/springb0ard/
  echo "install aspell"
  sudo apt install aspell -y 
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
  echo "git --version"
  git --version
  sudo mkdir /etc/springb0ard
  sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
  cd /etc/springb0ard/
  echo "Installing the Springb0ard filesystem..."
  git clone https://github.com/LanceTreyark/Springb0ard.git
  echo "Making springboard executable..."
  sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh  
else
  echo "Git is already installed on this system"
  echo "Installing the Springb0ard filesystem..."
  sudo mkdir /etc/springb0ard
  sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
  cd /etc/springb0ard/
  git clone https://github.com/LanceTreyark/Springb0ard.git
  echo "Making springb0ard executable..."
  sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
fi
echo "Adding alias commands..."
# append to file if it already exists
cat >>/home/$sudoUser/.bash_aliases <<EOF
alias hi="sudo apt update && sudo apt upgrade"
EOF
echo "Enabling the Alias file..."
sudo chmod +x /home/$sudoUser/.bash_aliases
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases




#echo "Installing Firewall"
#apt install ufw -y
#echo "Allow SSH through the firewall"
#ufw allow OpenSSH
#ufw enable
#ufw status
