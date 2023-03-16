#!/bin/bash
# nano 0a6d_x.sh
# sudo chmod +x 0a6d_x.sh
# ./0a6d_x.sh
#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<<comment
* TITLE: 0a6d_x.sh
* AUTHOR: Lance Pierson
* DATE: 3/11/2023

PURPOSE:


comment

#call vArs
mailDomain=$(cat /etc/springboard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springboard/vArs/regMailUser.txt)

echo "The script is live!"
sleep 1


sleep 1
echo "the script has concluded."
echo "bye"