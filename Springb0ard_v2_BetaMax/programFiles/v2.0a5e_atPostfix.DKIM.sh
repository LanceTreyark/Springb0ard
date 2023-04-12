#!/bin/bash
# Git Core: Yes
# nano v2.0a5e_atPostfix.DKIM.sh
# sudo chmod +x v2.0a5e_atPostfix.DKIM.sh
# ./v2.0a5e_atPostfix.DKIM.sh
echo "The script is live!"
#Call your vArs!
#Call your vArs!
yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/webAdminEmail.txt)
#webDomainName=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
#defaultScpAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
#scpExportPath=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt)
echo "           vArs Test:"
echo "-----------------------------"
echo "yourDomain=$yourDomain"
echo "mailDomain=$mailDomain"
echo "regMailUser=$regMailUser"
echo "sudoUser=$sudoUser"
echo "sudoUserID=$sudoUserID"
echo "myIP=$myIP"
echo "webAdminEmail=$webAdminEmail"
#echo "webDomainName=$webDomainName"
#echo "defaultScpAddr=$defaultScpAddr"
#echo "scpExportPath=$scpExportPath"
echo "-----------------------------"
sleep 1
sudo apt install opendkim opendkim-tools -y
sudo sed -i "/#Mode/a Mode                   sv" /etc/opendkim.conf
sudo sed -i "/#Domain/a Domain                 $mailDomain" /etc/opendkim.conf
sudo sed -i "/#Selector/a Selector               2020" /etc/opendkim.conf
sudo sed -i "/#KeyFile/a KeyFile                /etc/dkimkeys/example.private" /etc/opendkim.conf
cd /home/$sudoUser
echo "Create DKIM Keys"
sudo /usr/sbin/opendkim-genkey -b 2048 -d $mailDomain -s default
sudo cp default.txt /tmp/defaultX1.txt
sudo chown -R $sudoUserID:$sudoUserID /tmp/defaultX1.txt
# Pluck out the key from the header and footer
awk '/default\._domainkey.*\(/ {flag=1; next} /)/ {flag=0} flag && /p=/ {sub(/.*p=/, "p=", $0); sub(/".*/, "", $0); print $0; exit}' /tmp/defaultX1.txt > /tmp/DKIM_Top.txt
awk -F'"' '/default._domainkey/{getline; getline; print $2}' /tmp/defaultX1.txt > /tmp/DKIM_bottom.txt
# Read input file into variable
DKIM_Top=$(cat /tmp/DKIM_Top.txt)
DKIM_bottom=$(cat /tmp/DKIM_bottom.txt)
# Combine into a single string then break up into 64 char lines and wrap in quotes
echo $DKIM_Top$DKIM_bottom > /tmp/DKIM_Full.txt
echo ""
echo "-----------------------------------------------------------"
echo "Here is the raw DKIM public key prior to reformatting for easy DNS:"
echo "---"
cat /tmp/DKIM_Full.txt
echo "-----------------------------------------------------------"
echo ""
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
echo "-------------------------------------------------------------------------------------"
echo "| Here are your email DNS Records:                                                  |"
echo "| TYPE.........HOST.............ANSWER................................TTL......PRIO |"
echo "| A              @               $myIP                        300       N/A  "
echo "| A             WWW              $myIP                        300       N/A  "
echo "| A             mail             $myIP                        300       N/A  "
echo "| MX             @               mail.$mailDomain                  300       N/A  " 
echo "| TXT            @               v=spf1 ip4:$myIP -all        300       N/A  "  
echo "| TXT            @              PASTE_DKIM_KEYS_HERE                 300       N/A  "  
echo "| TXT          _dmarc          PASTE_DMARC_RECORD_HERE               300       N/A  "
echo "|------------------------------------------------------------------------------------|"
echo "|         Copy and paste this into the ANSWER field for your DKIM Keys:              |"
echo "| Omit any text before 'default._domain..' sometimes there is an '-e' don't add that |"
echo "|------------------------------------------------------------------------------------|"
cat /home/$sudoUser/DKIMwithHeader.txt
echo "|------------------------------------------------------------------------------------|"
echo "|        Copy and paste this into the ANSWER field for your DMARC Record:            |"
echo "|------------------------------------------------------------------------------------|"
echo "v=DMARC1; p=quarantine; rua=mailto:$regMailUser@$mailDomain; ruf=mailto:$regMailUser@$mailDomain; sp=none; aspf=r; adkim=r; pct=100;"
echo "|------------------------------------------------------------------------------------|"
echo "|                                   NOTE:                                            |"
echo "|      You need to set reverse DNS (PTR) on your server's host admin portal          |"
echo "|------------------------------------------------------------------------------------|"
echo "| IP ADDRESS...............REVERSE DNS NAME.................ATTACHED TO              |"
echo "| $myIP            mail.$mailDomain          mail.$mailDomain          "
echo "--------------------------------------------------------------------------------------"
rm /tmp/DKIM_Segmented.txt
rm /tmp/DKIM_Full.txt
rm /tmp/DKIM_bottom.txt
rm /tmp/DKIM_Top.txt
rm /tmp/defaultX1.txt
sleep 1
echo "the script has concluded."
echo "ONCE YOU HAVE ENTERED THE RECORDS enter the command 'bootmail' to reload "
echo "the mailserver, otherwise your new DNS records may not take as quickly"
echo ""
echo "To check the mail log you can nano the log with the command 'maillog'"
echo "To see all of the alias commands springboard added you can use the command 'springb0ard'"
echo "if you want to add your own additional alias command use 'nano ~/.bash_aliases'"
echo "If you run into trouble send me an error report by email at info@treyark.com"
echo "or DM me on Twitter @LanceTreyark"
echo "Bye!"