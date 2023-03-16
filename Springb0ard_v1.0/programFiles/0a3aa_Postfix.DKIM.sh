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

sudo apt install opendkim opendkim-tools -y

sudo sed -i "/#Mode/a Mode                   sv" /etc/opendkim.conf

sudo sed -i "/#Domain/a Domain                 $mailDomain" /etc/opendkim.conf
sudo sed -i "/#Selector/a Selector               2020" /etc/opendkim.conf
sudo sed -i "/#KeyFile/a KeyFile                /etc/dkimkeys/example.private" /etc/opendkim.conf

###
<<comment
"
#smtpd_banner = $myhostname ESMTP $mail_name (Debian/GNU) #<<no good
smtpd_banner = $myhostname ESMTP $mail_name
so:
sudo postconf -e 'smtpd_banner = $myhostname ESMTP $mail_name'
"

"
sudo apt install opendkim opendkim
sudo apt install opendkim opendkim-tools -y
sudo nano /etc/opendkim.conf
"

"
Domain                  forml0gic.com
Selector                2020
KeyFile         /etc/dkimkeys/example.private

"
"
Canonicalization        relaxed/simple
Mode                    v
Mode                    sv
#SubDomains             no
OversignHeaders         From

"

"
sudo /usr/sbin/opendkim-genkey -b 2048 -d formlogic.com -s default

sudo cat ~/default.txt

"
comment
###


sleep 1
echo "the script has concluded."
echo "bye"