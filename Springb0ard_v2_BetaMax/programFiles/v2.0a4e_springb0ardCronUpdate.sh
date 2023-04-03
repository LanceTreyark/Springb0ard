#!/bin/bash
# nano v2.0a4e_springb0ardCronUpdate.sh
# sudo chmod +x v2.0a4e_springb0ardCronUpdate.sh
# ./v2.0a4e_springb0ardCronUpdate.sh
# It is assumed that this script is called to action by a crontab entry.
# Update process for cron:
todaysDate=$(date +%m%d%y)
timeNow=$(date +%I%M%p)
vArsFilename="vArs${todaysDate}${timeNow}.tar.gz"
echo "todaysDate $todaysDate"
echo ""
echo "timeNow $timeNow"
echo ""
echo "vArs Log Name: $vArsFilename"
sleep 2
# rm -r /tmp/vArs.old
cd /etc/springb0ard
cp -r /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs /etc/springb0ard/
cd vArs
pwd
ls -1
cd /etc/springb0ard
sudo rm -r Springb0ard
git clone https://github.com/LanceTreyark/Springb0ard.git
cp -a /etc/springb0ard/vArs/. /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/
mkdir -p /etc/springb0ard/vArsLog
mv vArs /etc/springb0ard/vArsLog/$vArsFilename
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
echo "$(date) Update ran successfully" >> /etc/springb0ard/springb0ardUpdate.log