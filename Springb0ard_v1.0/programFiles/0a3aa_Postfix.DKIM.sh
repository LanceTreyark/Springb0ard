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


# Assign IP to variable:
myIPv4=$(ip addr show | awk '{if (match($2,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)) {print $2}}' | head -2 | tail -1)
cat >/tmp/ipSort3r.txt <<EOF
$myIPv4
EOF
myIP=$(awk -F/ '{print $1}' /tmp/ipSort3r.txt) 
echo "The IP address for this server is: $myIP"
# removing tmp file
sudo rm -r /tmp/ipSort3r.txt
echo "Add Host data to the end of hosts file:"
sleep 1
echo "We are going to add the domain name to the hosts file"
sleep 1
echo "here is the file currently:"
sleep 1
echo "------------------------------------------------------"
sudo cat /etc/hosts
echo "------------------------------------------------------"
read -p "press enter to ammend it to '127.0.0.1 localhost mail.$mailDomain'" meh
sudo sed -i "/127.0.0.1/a $myIP mail.$mailDomain" /etc/hosts
echo ""
sleep 1
echo "Okay here is the amended file:"
echo "------------------------------------------------------"
sudo cat /etc/hosts
echo "------------------------------------------------------"
echo ""
sleep 1
echo "the script has concluded."
echo "bye"