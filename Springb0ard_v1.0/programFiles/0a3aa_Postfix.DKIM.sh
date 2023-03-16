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

echo "The script is live!"
sleep 1


sleep 1
echo "the script has concluded."
echo "bye"