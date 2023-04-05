#!/bin/bash
# nano v2.0a4e_springb0ardCronUpdate.sh
# sudo chmod +x v2.0a4e_springb0ardCronUpdate.sh
# ./v2.0a4e_springb0ardCronUpdate.sh
# It is assumed that this script is called to action by a crontab entry.
# Update process for cron:
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
todaysDate=$(date +%m%d%y)
timeNow=$(date +%I%M%p)
vArsFilename="vArs${todaysDate}${timeNow}"
echo "todaysDate $todaysDate"
echo ""
echo "timeNow $timeNow"
echo ""
echo "vArs Log Name: $vArsFilename"
sleep 2
# rm -r /tmp/vArs.old
cd /etc/springb0ard/Springb0ard
#git pull

cp -r /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs /etc/springb0ard/
cd vArs
pwd
ls -1
cd /etc/springb0ard
sudo rm -r Springb0ard
git clone https://github.com/LanceTreyark/Springb0ard.git
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/
cp -a /etc/springb0ard/vArs/. /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/
mkdir -p /etc/springb0ard/vArsLog
mv vArs /etc/springb0ard/vArsLog/$vArsFilename
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh

echo "$(date) Update ran successfully" >> /etc/springb0ard/springb0ardUpdate.log
#echo "$(date) This is a better method" >> /etc/springb0ard/springb0ardUpdate.log