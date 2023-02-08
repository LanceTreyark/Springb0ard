#!/bin/bash

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
autoRepo1=$(cat /tmp/vArs/varAutoRepo1.txt)
gitOrigin1=$(cat /tmp/vArs/varGitOrigin1.txt)
gitEmail=$(cat /tmp/vArs/varGitEmail.txt)
gitName=$(cat /tmp/vArs/varGitName.txt)
GitRepoName=$(cat /tmp/vArs/varGitRepoName.txt)
nonRootUsrName=$(cat /tmp/vArs/varnonRootUsrName.txt)
echo "Declaring session Git Alias commands"
alias dude="./microInit_i1.sh"
alias commit="git add . && ./Q_Com.sh && git push -u origin main"
sleep 1
echo "Update ownership of the .ssh directory & .bash_aliases file"
sleep 1
echo "Before ownership change:"
ls -a -1 /home/$nonRootUsrName/
#-----------------------------------------------CHANGE 1000 to a variable based on a test function!!!!!!!!!!!!!!!!!
sudo chown -R 1000:1000 /home/$nonRootUsrName/.bash_aliases
sudo chown -R 1000:1000 /home/$nonRootUsrName/.ssh
echo "After ownership change:"
ls -a -1 /home/$nonRootUsrName/
#-------------------------------------------------------------------- Change ownership of vArs to 1000
sudo chown -R 1000:1000 /tmp/vars
echo "Add Alias commands"
sleep 1
cd /home/$nonRootUsrName/
pwd
ls -a -1 /home/$nonRootUsrName/
echo ""
echo ""
# Check for existence of the Alias file if it exists add these commands
if [ -e /home/$nonRootUsrName/.bash_aliases ]; then
    #echo "alias hi='sudo apt update && sudo apt upgrade'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias dude='./microInit_i1.sh'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias commit='git add . && ./Q_Com.sh && git push -u origin main'" >> /home/$nonRootUsrName/.bash_aliases
else
# If the file does not exist, create it and add these commands, later we will make it executable and add it as a current source.
    touch /home/$nonRootUsrName/.bash_aliases
    echo "alias hi='sudo apt update && sudo apt upgrade'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias dude='./microInit_i1.sh'" >> /home/$nonRootUsrName/.bash_aliases
    echo "alias commit='git add . && ./Q_Com.sh && git push -u origin main'" >> /home/$nonRootUsrName/.bash_aliases
fi

echo "Creating a gitHub directory in the home directory"
mkdir /home/$nonRootUsrName/$GitRepoName

<<comment
#echo "Copy two repository handling scripts into /tmp then cp to home new dir gitHub"
sleep 1
ls -a -1 /tmp
mkdir /tmp/exampleRepo
ls -a -1 /tmp
ls -a -1 /tmp/exampleRepo
curl -o /tmp/exampleRepo/Q_Com.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/Q_Com.sh
ls -a -1 /tmp/exampleRepo
curl -o /tmp/exampleRepo/microInit_i1.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/microInit_i1.sh
ls -a -1 /tmp/exampleRepo
curl -o /tmp/exampleRepo/Q_Com_v0.0.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/Q_Com_v0.0.sh 
ls -a -1 /tmp/exampleRepo
curl -o /tmp/exampleRepo/microInit_v0.0.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/microInit_v0.0.sh 
ls -a -1 /tmp/exampleRepo
ls -a -1 /home/$nonRootUsrName/
mkdir /home/$nonRootUsrName/$GitRepoName
ls -a -1 /home/$nonRootUsrName/
ls -a -1 /home/$nonRootUsrName/$GitRepoName/
cp -r /tmp/exampleRepo /home/$nonRootUsrName/$GitRepoName/
ls -a -1 /home/$nonRootUsrName/$GitRepoName/
#--------------------------PHASE TWO
#
echo ""
echo ""
# userID=$(id -u)
# echo "User ID is $userID"
echo ""
echo ""
sleep 1
# sudo chown -R $userID:$userID /home/$nonRootUsrName/$GitRepoName
cd /home/$nonRootUsrName/$GitRepoName
echo "In this Directory:"
pwd
echo "Here is a list of the contents before we make a change:"
ls -a -1
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
cp -r /home/$nonRootUsrName/$GitRepoName/exampleRepo /home/$nonRootUsrName/$GitRepoName/$autoRepo1
echo "Here is a list of the contents after the change"
ls -a -1
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
echo "For the command scripts to work, sudo will be required to make them executable"
sleep 1
echo "In this Directory:"
pwd
echo "Here is a list of the contents before we make a change:"
ls -a -1 /home/$nonRootUsrName/
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
sudo chmod +x /home/$nonRootUsrName/.bash_aliases
echo "Here is a list of the contents after the change"
ls -a -1 /home/$nonRootUsrName/
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
echo "In this Directory:"
echo "/home/$nonRootUsrName/$GitRepoName/exampleRepo/"
echo "Here is a list of the contents before we make a change:"
ls -a -1 /home/$nonRootUsrName/$GitRepoName/exampleRepo/
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
sudo chmod +x /home/$nonRootUsrName/$GitRepoName/exampleRepo/Q_Com.sh
sudo chmod +x /home/$nonRootUsrName/$GitRepoName/exampleRepo/microInit_i1.sh
echo "Here is a list of the contents after the change"
ls -a -1 /home/$nonRootUsrName/$GitRepoName/exampleRepo/
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
echo "In this Directory:"
echo "/home/$nonRootUsrName/$GitRepoName/$autoRepo1/"
echo "Here is a list of the contents before we make a change:"
ls -a -1 /home/$nonRootUsrName/$GitRepoName/$autoRepo1/
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
sudo chmod +x /home/$nonRootUsrName/$GitRepoName/$autoRepo1/Q_Com.sh
sudo chmod +x /home/$nonRootUsrName/$GitRepoName/$autoRepo1/microInit_i1.sh
sudo chmod +x /home/$nonRootUsrName/$GitRepoName/$autoRepo1/Q_Com_v0.0.sh
sudo chmod +x /home/$nonRootUsrName/$GitRepoName/$autoRepo1/microInit_v0.0.sh
echo "Here is a list of the contents after the change"
ls -a -1 /home/$nonRootUsrName/$GitRepoName/$autoRepo1/
echo ""
echo "-----------------------------------------------------------"
echo ""
sleep 1
#--------------------------PHASE THREE
#-------------------------------------------------------------------- 1
comment

echo "Initialize $autoRepo1 and declare global git ownership"
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
cd /home/$nonRootUsrName/$GitRepoName/$autoRepo1
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
sleep 1
echo "Before change:"
ls -a -1 /tmp
sudo rm -r /tmp/gitHub
sudo rm -r /tmp/exampleRepo
sleep 1
echo "After change:"
ls -a -1
sleep 1
echo "The script has concluded"
sleep 1
cd /home/$nonRootUsrName/
pwd
#
#
#TODO in PhaseZero we will need to addPhaseThree and make executable etc
echo "End of script."
echo "Begin Postfix installation script"
sleep 1
echo "Press Enter to continue..."
read -s -p ""
# ./PhaseThree....