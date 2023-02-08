#!/bin/bash
<<comment
Author: LP
Date: pre 2.2.23
UNIT TEST PURPOSE:

Installation Phase -Install Git

1 Verifies if 'curl' is installed, if not it installs it using 'sudo apt install curl -y'
2 Creates a directory '/tmp/gitHub'
3 Downloads the Git archive to '/tmp/gitHub/git.tar.gz'
4 Extracts the contents of the archive and removes the archive
5 Copies the extracted contents to the home directory
6 Installs the following packages: aspell, libcurl4-openssl-dev, libexpat1-dev, gettext, tcl, make, gcc, libssl-dev, and zlib1g-dev using 'sudo apt install [package-name] -y'
7 Changes the current directory to '/home/$nonRootUsrName/gitHub/git-2.39.0' and builds and installs Git using 'make' and 'sudo make prefix=/usr/local install'
8 Displays the version of Git using 'git --version'
9 The script ends and the next part of the script "Begin Git configuration script" is displayed.
comment
echo "Phase One Unit Test has started, "
sleep 1
echo "Verify 'curl' is installed"
sudo apt install curl -y
sleep 1
echo "mkdir /tmp/gitHub " 
mkdir /tmp/gitHub
echo "sudo curl -o /tmp/gitHub/git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.39.0.tar.gz "
sudo curl -o /tmp/gitHub/git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.39.0.tar.gz
echo "cd /tmp/gitHub && sudo tar -xf git.tar.gz && sudo rm -r git.tar.gz && cd -"
cd /tmp/gitHub && sudo tar -xf git.tar.gz && sudo rm -r git.tar.gz && cd -
echo "cp -r /tmp/gitHub /home/$nonRootUsrName/"
cp -r /tmp/gitHub /home/$nonRootUsrName/
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
echo "cd /home/$nonRootUsrName/gitHub/git-2.39.0" 
cd /home/$nonRootUsrName/gitHub/git-2.39.0
pwd
echo "sudo make prefix=/usr/local all" 
sudo make prefix=/usr/local all
echo "sudo make prefix=/usr/local install"
sudo make prefix=/usr/local install
sleep 1
echo "git --version"
git --version
echo "End of script."
echo "Begin Git configuration script"
sleep 1
echo "Press Enter to continue..."
read -s -p ""
goTwo
