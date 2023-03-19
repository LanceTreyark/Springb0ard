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
# at some point hard set this IP into a written vArs entry:
# Assign IP to variable:
myIPv4=$(ip addr show | awk '{if (match($2,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)) {print $2}}' | head -2 | tail -1)
cat >/tmp/ipSort3r.txt <<EOF
$myIPv4
EOF
myIP=$(awk -F/ '{print $1}' /tmp/ipSort3r.txt) 
#echo "The IP address for this server is: $myIP"
# removing tmp file
sudo rm -r /tmp/ipSort3r.txt
#
echo "The script is live!"
sleep 1

#sudo apt install opendkim opendkim-tools -y
#sudo sed -i "/#Mode/a Mode                   sv" /etc/opendkim.conf
#sudo sed -i "/#Domain/a Domain                 $mailDomain" /etc/opendkim.conf
#sudo sed -i "/#Selector/a Selector               2020" /etc/opendkim.conf
#sudo sed -i "/#KeyFile/a KeyFile                /etc/dkimkeys/example.private" /etc/opendkim.conf

# Make sure you are in the proper directory
cd /home/$sudoUser

# \/ This Creates our DKIM Keys
sudo /usr/sbin/opendkim-genkey -b 2048 -d $mailDomain -s default


# \/ This creates a variable to hold the current users id # ie 1001
sudoUserID=$(id -u $sudoUser)


#----------------------------------------------------------
# Begin with DNS Syntaxing
#----------------------------------------------------------
#Here is the plan:

# PHASE 1) we copy the actual key file to a working file & make it writable

# \/ This copies the keys to a working file that we can modify or 
#    delete without messing with the system
sudo cp default.txt defaultX1.txt

### \/ This makes sure our working file is writable for the corrent
#       user because the original file is owned by root.
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/defaultX1.txt

# PHASE 2) Pluck out the key from the header and footer
awk '/default\._domainkey.*\(/ {flag=1; next} /)/ {flag=0} flag && /p=/ {sub(/.*p=/, "p=", $0); sub(/".*/, "", $0); print $0; exit}' defaultX1.txt > DKIM_Top.txt
awk -F'"' '/default._domainkey/{getline; getline; print $2}' defaultX1.txt > DKIM_bottom.txt
# read input file into variable
DKIM_Top=$(cat DKIM_Top.txt)
DKIM_bottom=$(cat DKIM_bottom.txt)
# PHASE 3) Combine into a single string then reak up into 64 char lines and wrap in quotes
echo $DKIM_Top$DKIM_bottom > DKIM_Full.txt
#cat DKIM_Full.txt
DKIM_Full=$(cat DKIM_Full.txt)
# insert new quoted lines every 64 characters 
linoel=$(echo "$DKIM_Full" | fold -w 64 -s | sed 's/^/"/; s/$/"/')
# write output to file
echo "$linoel" > DKIM_Segmented.txt


#!/bin/bash
# PHASE 4) add DNS header
# 
# This reads the contents of DKIM_Segmented.txt into a variable
header=$(cat DKIM_Segmented.txt)

# This adds the DNS record prefix
header="\"default._domainkey IN TXT  ( \"v=DKIM1; h=sha256; k=rsa; \" \n$header)\""  

# This outputs the reformatted contents to DKIMwithHeader.txt
echo -e "$header" > DKIMwithHeader.txt

#cat DKIMwithHeader.txt
echo "Here are your email DNS Records:"
echo "TYPE.........HOST.............ANSWER........................TTL......PRIO"
echo "TXT            @              v=spf1 ip4:$myIP -all         300       N/A"  
echo "TXT            @              >paste DKIM keys here<        300       N/A"  
echo "TXT  _dmarc.forml0gic.com    >paste DMARC Record here<      300       N/A"

echo "Copy and paste this into the ANSWER field for your DKIM Keys:"
echo "------------------------------------------------------"
cat DKIMwithHeader.txt
echo "------------------------------------------------------"
echo ""
echo ""
echo "Copy and paste this into the ANSWER field for your DMARC Record:"
echo "------------------------------------------------------"
echo "v=DMARC1; p=quarantine; rua=mailto:$regMailUser@$mailDomain; ruf=mailto:$regMailUser@$mailDomain; sp=none; aspf=r; adkim=r; pct=100;"
echo "------------------------------------------------------"


sleep 1
echo "the script has concluded."
echo "bye"