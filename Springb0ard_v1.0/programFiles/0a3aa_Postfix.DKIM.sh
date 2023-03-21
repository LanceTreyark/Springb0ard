#!/bin/bash
# nano 0a3aa_Postfix.DKIM.sh
# sudo chmod +x 0a3aa_Postfix.DKIM.sh
# ./0a3aa_Postfix.DKIM.sh
#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<<comment
* TITLE: 0a3aa_Postfix.DKIM.sh
* AUTHOR: Lance Pierson
* DATE: 3/11 -3/19/2023

PURPOSE:

This is an addendum to the automatic SMTP email server installer 
This code installs DKIM keys and provides the user with all of the required email DNS records
comment

echo "The script is live!"

#Call your vArs!
yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)

sleep 1

sudo apt install opendkim opendkim-tools -y
sudo sed -i "/#Mode/a Mode                   sv" /etc/opendkim.conf
sudo sed -i "/#Domain/a Domain                 $mailDomain" /etc/opendkim.conf
sudo sed -i "/#Selector/a Selector               2020" /etc/opendkim.conf
sudo sed -i "/#KeyFile/a KeyFile                /etc/dkimkeys/example.private" /etc/opendkim.conf

# Make sure you are in the proper directory
cd /home/$sudoUser

# \/ This Creates our DKIM Keys
sudo /usr/sbin/opendkim-genkey -b 2048 -d $mailDomain -s default


# \/ This creates a variable to hold the specified users id # ie 1001
sudoUserID=$(id -u $sudoUser)


#----------------------------------------------------------
# Begin with DNS Syntaxing
#----------------------------------------------------------
#Here is the plan:

# PHASE 1) we copy the actual key file to a working file & make it writable

# \/ This copies the keys to a working file that we can modify or 
#    delete without messing with the system
sudo cp default.txt /tmp/defaultX1.txt

### \/ This makes sure our working file is writable for the current
#       user because the original file is owned by root.
sudo chown -R $sudoUserID:$sudoUserID /tmp/defaultX1.txt

# PHASE 2) Pluck out the key from the header and footer
awk '/default\._domainkey.*\(/ {flag=1; next} /)/ {flag=0} flag && /p=/ {sub(/.*p=/, "p=", $0); sub(/".*/, "", $0); print $0; exit}' /tmp/defaultX1.txt > /tmp/DKIM_Top.txt
awk -F'"' '/default._domainkey/{getline; getline; print $2}' /tmp/defaultX1.txt > /tmp/DKIM_bottom.txt
# read input file into variable
DKIM_Top=$(cat /tmp/DKIM_Top.txt)
DKIM_bottom=$(cat /tmp/DKIM_bottom.txt)
# PHASE 3) Combine into a single string then reak up into 64 char lines and wrap in quotes
echo $DKIM_Top$DKIM_bottom > /tmp/DKIM_Full.txt
#cat /tmp/DKIM_Full.txt
DKIM_Full=$(cat /tmp/DKIM_Full.txt)
# insert new quoted lines every 64 characters 
linoel=$(echo "$DKIM_Full" | fold -w 64 -s | sed 's/^/"/; s/$/"/')
# write output to file 
# We keep this in ~/ Dir
echo "$linoel" > /tmp/DKIM_Segmented.txt
header=$(cat /tmp/DKIM_Segmented.txt)
# This adds the DNS record prefix
header="default._domainkey IN TXT  ( \"v=DKIM1; h=sha256; k=rsa; \" \n$header)"  
# This outputs the reformatted contents to DKIMwithHeader.txt
echo -e "$header" > /home/$sudoUser/DKIMwithHeader.txt
echo "| Here are your email DNS Records:                                                  |"
echo "| TYPE.........HOST.............ANSWER................................TTL......PRIO |"
echo "| A              @               $myIP                        300       N/A |"
echo "| A             WWW              $myIP                        300       N/A |"
echo "| A             mail             $myIP                        300       N/A |"
echo "| MX             @               mail.$mailDomain                  300       N/A |" 
echo "| TXT            @               v=spf1 ip4:$myIP -all        300       N/A |"  
echo "| TXT            @              >paste DKIM keys here<                300       N/A |"  
echo "| TXT          _dmarc          >paste DMARC Record here<              300       N/A |"
echo "-------------------------------------------------------------------------------------"
echo "|         Copy and paste this into the ANSWER field for your DKIM Keys:             |"
echo "-------------------------------------------------------------------------------------"
cat /home/$sudoUser/DKIMwithHeader.txt
echo "-------------------------------------------------------------------------------------"
echo "|        Copy and paste this into the ANSWER field for your DMARC Record:           |"
echo "-------------------------------------------------------------------------------------"
echo "v=DMARC1; p=quarantine; rua=mailto:$regMailUser@$mailDomain; ruf=mailto:$regMailUser@$mailDomain; sp=none; aspf=r; adkim=r; pct=100;"
echo "-------------------------------------------------------------------------------------"
echo "|                                   NOTE:                                           |"
echo "|      You need to set reverse DNS (PTR) on your server's host admin portal         |"
echo "-------------------------------------------------------------------------------------"
echo "| IP ADDRESS...............REVERSE DNS NAME.................ATTACHED TO             |"
echo "| $myIP            mail.$mailDomain          mail.$mailDomain         |"
echo "-------------------------------------------------------------------------------------"
rm /tmp/DKIM_Segmented.txt
rm /tmp/DKIM_Full.txt
rm /tmp/DKIM_bottom.txt
rm /tmp/DKIM_Top.txt
rm /tmp/defaultX1.txt
sleep 1
echo "the script has concluded."
echo "bye"