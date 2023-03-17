#!/bin/bash
# nano 0a3aa_Postfix.DKIM.sh
# sudo chmod +x 0a3aa_Postfix.DKIM.sh
# ./0a3aa_Postfix.DKIM.sh
#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<<comment
* TITLE: 0a3aa_Postfix.DKIM.sh
* AUTHOR: Lance Pierson
* DATE: 3/11/2023

PURPOSE:

This is an addendum to the automatic SMTP email server installer 
This code installs DKIM keys and provides the user with all of the required email DNS records
comment

#call vArs
mailDomain=$(cat /etc/springboard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springboard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springboard/vArs/sudoUser.txt)
echo "The script is live!"
sleep 1

#sudo apt install opendkim opendkim-tools -y
#sudo sed -i "/#Mode/a Mode                   sv" /etc/opendkim.conf
#sudo sed -i "/#Domain/a Domain                 $mailDomain" /etc/opendkim.conf
#sudo sed -i "/#Selector/a Selector               2020" /etc/opendkim.conf
#sudo sed -i "/#KeyFile/a KeyFile                /etc/dkimkeys/example.private" /etc/opendkim.conf
cd /home/$sudoUser
#sudo /usr/sbin/opendkim-genkey -b 2048 -d $mailDomain -s default
echo "----------------------------------------"
sudo cat /home/$sudoUser/default.txt
echo "----------------------------------------"
#
echo ""
echo ""
echo "converting DKIM to dns txt file format..."
echo ""
sudoUserID=$(id -u $sudoUser)
sudo cp default.txt defaultx.txt
#make sure ownership is readable w/o sudo
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/defaultx.txt
# Define file paths
src_file=~/defaultx.txt
dest_file=~/defaultMod.txt

# Read contents of source file and modify format
content=$(cat $src_file | sed 's/\(.*\)/"\1"/' | tr '\n' ' ' | sed 's/ "/"/g' | sed 's/"/\\"/g' | sed 's/;/"; /g')

# Create new file with modified content
echo -e "$content" > $dest_file

# Print success message
echo "Contents of $src_file have been copied to $dest_file and modified for DNS TXT record format."
echo "----------------------------------------"
cat $dest_file
echo "----------------------------------------"
###
<<comment
ADD A VAR
# echo "variable" >> /etc/springboard/vArs/variable.txt

CALL A VAR
# variable=$(cat /etc/springboard/vArs/variable.txt)
comment
###
sleep 1
echo "the script has concluded."
echo "bye"