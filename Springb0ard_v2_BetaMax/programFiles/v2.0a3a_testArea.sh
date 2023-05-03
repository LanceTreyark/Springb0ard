#!/bin/bash
# This is for running tests 
# you can execute or edit this script with these alias commands:
# sb-test         --Run test script
# sb-etest        --Edit test script

echo "The script is live!"
#Call your vArs!
yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
defaultScpAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
scpExportPath=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt)
echo "           vArs Test:"
echo "-----------------------------"
echo "yourDomain=$yourDomain"
echo "mailDomain=$mailDomain"
echo "regMailUser=$regMailUser"
echo "sudoUser=$sudoUser"
echo "sudoUserID=$sudoUserID"
echo "myIP=$myIP"
echo "webAdminEmail=$webAdminEmail"
echo "webDomainName=$webDomainName"
echo "defaultScpAddr=$defaultScpAddr"
echo "scpExportPath=$scpExportPath"
echo "-----------------------------"
# IPV6 -In
myIPv6=$(ip addr show | awk '/inet6 .* scope global/ {split($2, arr, "/"); print arr[1]}')
cat >/tmp/ipSorter.txt <<EOF
$myIPv6
EOF
myIP6=$(awk '{print $1}' /tmp/ipSorter.txt)
echo "The IPv6 address for this server is: $myIP6"
rm -r /tmp/ipSorter.txt
# IPV6 -Out

echo "-------------------------------------------------------------------------------------"
echo "| Here are your email DNS Records:                                                  |"
echo "| TYPE.........HOST.............ANSWER................................TTL......PRIO |"
echo "| A              @               $myIP                        300       N/A  "
echo "| A             WWW              $myIP                        300       N/A  "
echo "| A             mail             $myIP                        300       N/A  "
echo "| MX             @               mail.$mailDomain                  300       N/A  " 
echo "| TXT            @              PASTE_SPF_RECORD_HERE                300       N/A  "
echo "| TXT            @              PASTE_DKIM_KEYS_HERE                 300       N/A  " 
echo "| TXT          _dmarc          PASTE_DMARC_RECORD_HERE               300       N/A  "
echo "|------------------------------------------------------------------------------------|"
echo "|        Copy and paste this into the ANSWER field for your SPF Record:              |"
echo "|------------------------------------------------------------------------------------|"
echo "v=spf1 ip4:$myIP ip6:$myIP6 -all"
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
