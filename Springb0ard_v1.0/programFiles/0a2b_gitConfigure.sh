#!/bin/bash

#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Add a git repo by running in any dir
# "gitinit" for local or "gitroot" for root
<<comment
Author: LP
Date: pre 2.2.23
UNIT TEST PURPOSE:
Initial git configuration

1 Adds an alias file with 3 commands
  A "hi" updates system with a single command
  B"dude" initializes a new git repository
  C"commit" prompts for a commit message and commits file to GitHub
2 Creates a template/example repo in the home directory containing scripts to run "dude" and "commit" commands
3 Sets up the first repo and sets up global ownership
4 Reads values from text files for the following variables:
  A autoRepo1
  B gitOrigin1
  C gitEmail
  D gitName
  E GitRepoName
  F nonRootUsrName
5 Sets ownership of the .ssh directory and .bash_aliases file to 1000
6 Changes ownership of the vArs folder to 1000
7 Adds alias commands to the .bash_aliases file
8 Checks for the existence of the .bash_aliases file and if it exists, adds alias commands
comment
# TRIM THE FAT
<<comment Added to Zero
read -p "Choose a file name for your first auto repo:  " autoRepo1
read -p "What is the remote origin for this new repository?   " gitOrigin1
read -p "What is your Git user email?  " gitEmail #lance@treyark.com
read -p "What is your Git user name?  " gitName   #LanceTreyark
read -p "Enter a file name for your Git repository root folder (or press enter for default 'gitRepo'): " GitRepoName
comment
# Call your vArs 
autoRepo1=$(cat /etc/Springb0ard_v1.0/vArs/varAutoRepo1.txt)
gitOrigin1=$(cat /etc/Springb0ard_v1.0/vArs/varGitOrigin1.txt)
gitEmail=$(cat /etc/Springb0ard_v1.0/vArs/varGitEmail.txt)
gitName=$(cat /etc/Springb0ard_v1.0/vArs/varGitName.txt)
GitRepoName=$(cat /etc/Springb0ard_v1.0/vArs/varGitRepoName.txt)
nonRootUsrName=$(cat /etc/Springb0ard_v1.0/vArs/varnonRootUsrName.txt)
sleep 1
echo "Update ownership of the .ssh directory & .bash_aliases file"
sleep 1
echo "Before ownership change:"
ls -a -1 /home/$nonRootUsrName/
userID=$(id -u)
sudo chown -R $userID:$userID /home/$nonRootUsrName/.bash_aliases
sudo chown -R $userID:$userID /home/$nonRootUsrName/.ssh
echo "After ownership change:"
ls -a -1 /home/$nonRootUsrName/
echo "Add Alias commands"
sleep 1
cd /home/$nonRootUsrName/
pwd
ls -a -1 /home/$nonRootUsrName/
echo ""
# Check for existence of the Alias file if it exists add these commands
if [ -e /home/$nonRootUsrName/.bash_aliases ]; then
    echo "alias gitinit='sh /etc/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias gitroot='sh /etc/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias commit='git add . && ./Q_Com.sh && git push -u origin main'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias commitr='sudo git add . && sudo ./Q_Com.sh && sudo git push -u origin main'" >> /home/$nonRootUsrName/.bash_aliases
else
# If the file does not exist, create it and add these commands, later we will make it executable and add it as a current source.
    touch /home/$nonRootUsrName/.bash_aliases
    echo "alias hi='sudo apt update && sudo apt upgrade'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias gitinit='sh /etc/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias gitroot='sh /etc/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias commit='git add . && ./Q_Com.sh && git push -u origin main'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias commitr='sudo git add . && sudo ./Q_Com.sh && sudo git push -u origin main'" >> /home/$nonRootUsrName/.bash_aliases

fi
echo "Making the alias commands available in the current session" 
alias gitinit="sh /etc/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh"
alias gitroot="sh /etc/Springb0ard_v1.0/programFiles/0a2c_gitLocalAlias.sh"
alias commit="git add . && ./Q_Com.sh && git push -u origin main"
alias commitr="sudo git add . && sudo ./Q_Com.sh && sudo git push -u origin main"
echo "Initialize exampleDir and declare global git ownership"
cp /etc/Springb0ard_v1.0/exampleDir /home/$nonRootUsrName/gitHub/
#make sure it's owned by the user
sudo chown -R $userID:$userID /home/$nonRootUsrName/gitHub/exampleDir
sleep 1
# check the server for an ssh key, if one does not exist offer to make one
# ask user if the key has been added to github if not the commit will not work.
#-----------------------------------------------------------------------------
if [ -f /home/$nonRootUsrName/.ssh/id_rsa.pub ]; then
    cat /home/$nonRootUsrName/.ssh/id_rsa.pub
    read -p "Have you added this key to your Github settings? (Y/N) " response
    if [ "$response" = "n" ]; then
        echo "Please add this key to your Github settings."
    fi
else
    read -p "It appears that an ssh key has not been generated. Would you like to create one? (Y/N) " response
    if [ "$response" = "y" ]; then
        ssh-keygen
        echo ""
        cat /home/$nonRootUsrName/.ssh/id_rsa.pub
        echo ""
        echo "Please add this key to your Github settings."
        echo ""
    else
        echo "If you dont add the ssh-key the communication with GitHub will fail. are you shure you want to skip this?"
        read -p "Enter (Y/N): " choice
        if [ "$choice" = "n" ]; then
            ssh-keygen
            cat /home/$nonRootUsrName/.ssh/id_rsa.pub
            echo "Please add this key to your Github settings."
        fi
    fi
fi
#-----------------------------------------------------------------------------
echo "Press Enter to continue..."
read -s -p ""
#-------------------------------------------------------------------- 0
cd /home/$nonRootUsrName/gitHub/exampleDir
pwd
git config --global user.email "$gitEmail"
git config --global user.name "$gitName"
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin $gitOrigin1
git push -u origin main
sleep 1
echo "Removing temp files..."
echo "Press Enter to continue..."
read -s -p ""
sleep 1
echo "Before change:"
ls -a -1 /tmp
sudo rm -r /tmp/gitHub
sleep 1
echo "After change:"
ls -a -1
sleep 1
echo "The script has concluded"
sleep 1
cd /home/$nonRootUsrName/
pwd
echo "End of script '0a2b_gitConfigure.sh'."
#echo "Begin Postfix installation script"
#sleep 1
#echo "Press Enter to continue..."
#read -s -p ""