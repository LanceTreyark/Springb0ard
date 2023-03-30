#!/bin/bash
# nano v2.0a5c_yatGitAddAcct.sh
# sudo chmod +x v2.0a5c_yatGitAddAcct.sh
# ./v2.0a5c_yatGitAddAcct.sh

<<comment
Purpose
Add the git global variables by setting up a home git directory
later this can be used to monitor server processes and crontab 
also this needs to use a script to initialize a new directory with dudes tools
add to the dude command that way we dont actually have to add that script to these directories before running the dude 
command. it will just run from /etc/springb0ard...
Make a modified script from the example dir in springb0ard.
comment
yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/vArs/mailDomain.txt)
#---------------------------------------------------------This script assumes the alias file exits just add dudes commands
#---------------------------------------------------------This script assumes the alias file exits just add dudes commands
#---------------------------------------------------------This script assumes the alias file exits just add dudes commands
#---------------------------------------------------------This script assumes the alias file exits just add dudes commands
#---------------------------------------------------------This script assumes the alias file exits just add dudes commands
#---------------------------------------------------------This script assumes the alias file exits just add dudes commands
read -p "What is the remote origin for this new repository?   " gitOrigin1
read -p "What is your Git user email?  " gitEmail 
read -p "What is your Git user name?  " gitName   
GitRepoName="gitRepo"
echo "Declaring session Git Alias commands"
alias dude="./microInit_i1.sh"
alias commit="git add . && ./Q_Com.sh && git push -u origin main"
#echo "Update ownership of the .ssh directory & .bash_aliases file"
#echo "Before ownership change:"
#ls -a -1 /home/$sudoUser/
#sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases
#sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh
#echo "After ownership change:"
#ls -a -1 /home/$sudoUser/
#sudo chown -R $sudoUserID:$sudoUserID /tmp/vars
echo "Add Alias commands"
cd /home/$sudoUser/
pwd
#ls -a -1 /home/$sudoUser/
#echo ""
#echo ""
# Check for existence of the Alias file if it exists add these commands
#if [ -e /home/$sudoUser/.bash_aliases ]; then
    #echo "alias hi='sudo apt update && sudo apt upgrade'" >> /home/$sudoUser/.bash_aliases
    echo "alias dude='./microInit_i1.sh'" >> /home/$sudoUser/.bash_aliases
    echo "alias commit='git add . && ./Q_Com.sh && git push -u origin main'" >> /home/$sudoUser/.bash_aliases
#else
# If the file does not exist, create it and add these commands, later we will make it executable and add it as a current source.
#    touch /home/$sudoUser/.bash_aliases
#    echo "alias hi='sudo apt update && sudo apt upgrade'" >> /home/$sudoUser/.bash_aliases
#    echo "alias dude='./microInit_i1.sh'" >> /home/$sudoUser/.bash_aliases
#    echo "alias commit='git add . && ./Q_Com.sh && git push -u origin main'" >> /home/$sudoUser/.bash_aliases
#fi
#
#-------------------------------------------------------------------- 1
#echo "Curl two repository handling scripts into /tmp then cp to home new dir gitHub"
#ls -a -1 /tmp
#mkdir /tmp/exampleRepo
#ls -a -1 /tmp
#ls -a -1 /tmp/exampleRepo
#curl -o /tmp/exampleRepo/Q_Com.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/Q_Com.sh
#ls -a -1 /tmp/exampleRepo
#curl -o /tmp/exampleRepo/microInit_i1.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/microInit_i1.sh
#ls -a -1 /tmp/exampleRepo
#curl -o /tmp/exampleRepo/Q_Com_v0.0.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/Q_Com_v0.0.sh 
#ls -a -1 /tmp/exampleRepo
#curl -o /tmp/exampleRepo/microInit_v0.0.sh https://raw.githubusercontent.com/LanceTreyark/ExperimentalUnits/main/microInit_v0.0.sh 
##ls -a -1 /tmp/exampleRepo
#ls -a -1 /home/$sudoUser/
mkdir /home/$sudoUser/$GitRepoName
ls -a -1 /home/$sudoUser/
ls -a -1 /home/$sudoUser/$GitRepoName/

#--------------------------------------------GET FINAL PATH TO THE EXAMPLE REPO IN ETC SO WE CAN USE DUDE TO COPY FILES TO WHEREVER
#----------------------------COME BACK AND FINISH AFTER THAT IS DONE.

cp -r /tmp/exampleRepo /home/$sudoUser/$GitRepoName/
ls -a -1 /home/$sudoUser/$GitRepoName/
#--------------------------PHASE TWO
#
echo ""
echo ""
userID=$(id -u)
echo "User ID is $userID"
echo ""
echo ""

sudo chown -R $userID:$userID /home/$sudoUser/$GitRepoName
cd /home/$sudoUser/$GitRepoName
echo "In this Directory:"
pwd
echo "Here is a list of the contents before we make a change:"
ls -a -1
echo ""
echo "-----------------------------------------------------------"
echo ""

cp -r /home/$sudoUser/$GitRepoName/exampleRepo /home/$sudoUser/$GitRepoName/$autoRepo1
echo "Here is a list of the contents after the change"
ls -a -1
echo ""
echo "-----------------------------------------------------------"
echo ""

echo "For the command scripts to work, sudo will be required to make them executable"

echo "In this Directory:"
pwd
echo "Here is a list of the contents before we make a change:"
ls -a -1 /home/$sudoUser/
echo ""
echo "-----------------------------------------------------------"
echo ""

sudo chmod +x /home/$sudoUser/.bash_aliases
echo "Here is a list of the contents after the change"
ls -a -1 /home/$sudoUser/
echo ""
echo "-----------------------------------------------------------"
echo ""

echo "In this Directory:"
echo "/home/$sudoUser/$GitRepoName/exampleRepo/"
echo "Here is a list of the contents before we make a change:"
ls -a -1 /home/$sudoUser/$GitRepoName/exampleRepo/
echo ""
echo "-----------------------------------------------------------"
echo ""

sudo chmod +x /home/$sudoUser/$GitRepoName/exampleRepo/Q_Com.sh
sudo chmod +x /home/$sudoUser/$GitRepoName/exampleRepo/microInit_i1.sh
echo "Here is a list of the contents after the change"
ls -a -1 /home/$sudoUser/$GitRepoName/exampleRepo/
echo ""
echo "-----------------------------------------------------------"
echo ""

echo "In this Directory:"
echo "/home/$sudoUser/$GitRepoName/$autoRepo1/"
echo "Here is a list of the contents before we make a change:"
ls -a -1 /home/$sudoUser/$GitRepoName/$autoRepo1/
echo ""
echo "-----------------------------------------------------------"
echo ""

sudo chmod +x /home/$sudoUser/$GitRepoName/$autoRepo1/Q_Com.sh
sudo chmod +x /home/$sudoUser/$GitRepoName/$autoRepo1/microInit_i1.sh
sudo chmod +x /home/$sudoUser/$GitRepoName/$autoRepo1/Q_Com_v0.0.sh
sudo chmod +x /home/$sudoUser/$GitRepoName/$autoRepo1/microInit_v0.0.sh
echo "Here is a list of the contents after the change"
ls -a -1 /home/$sudoUser/$GitRepoName/$autoRepo1/
echo ""
echo "-----------------------------------------------------------"
echo ""

#--------------------------PHASE THREE
#-------------------------------------------------------------------- 1
echo "Initialize $autoRepo1 and declare global git ownership"

# check the server for an ssh key, if one does not exist offer to make one
# ask user if the key has been added to github if not the commit will not work.
#-----------------------------------------------------------------------------
if [ -f /home/$sudoUser/.ssh/id_rsa.pub ]; then
    cat /home/$sudoUser/.ssh/id_rsa.pub
    read -p "Have you added this key to your Github settings? (Y/N) " response
    if [ "$response" = "n" ]; then
        echo "Please add this key to your Github settings."
    fi
else
    read -p "It appears that an ssh key has not been generated. Would you like to create one? (Y/N) " response
    if [ "$response" = "y" ]; then
        ssh-keygen
        echo ""
        cat /home/$sudoUser/.ssh/id_rsa.pub
        echo ""
        echo "Please add this key to your Github settings."
        echo ""
    else
        echo "If you dont add the ssh-key the communication with GitHub will fail. are you shure you want to skip this?"
        read -p "Enter (Y/N): " choice
        if [ "$choice" = "n" ]; then
            ssh-keygen
            cat /home/$sudoUser/.ssh/id_rsa.pub
            echo "Please add this key to your Github settings."
        fi
    fi
fi
cd /home/$sudoUser/$GitRepoName/$autoRepo1
pwd
git config --global user.email "$gitEmail"
git config --global user.name "$gitName"
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin $gitOrigin1
git push -u origin main
echo "Removing temp files..."
echo "Before change:"
ls -a -1 /tmp
sudo rm -r /tmp/gitHub
sudo rm -r /tmp/exampleRepo
echo "After change:"
ls -a -1
echo "The script has concluded"
cd /home/$sudoUser/
pwd
