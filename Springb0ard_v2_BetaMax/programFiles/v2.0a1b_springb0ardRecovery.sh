#!/bin/bash
# nano /etc/springb0ard/v2.0a1b_springb0ardRecovery.sh
# sudo chmod +x /etc/springb0ard/v2.0a1b_springb0ardRecovery.sh
# sh /etc/springb0ard/v2.0a1b_springb0ardRecovery.sh
# alias sp-recovery="sh /etc/springb0ard/v2.0a1b_springb0ardRecovery.sh"
# If an issue happens during an update where the springboard directory deletes itself this
# tool will bring it back from the dead.

cd /etc/springb0ard/vArsLog
echo "------------------------------------"
ls -1
echo "------------------------------------"
read -p "please copy and paste the most recent backup file ie: 'vArs0407231200AM'" backupFile
sudoUserID=$(cat /etc/springb0ard/vArsLog/$backupFile/sudoUserID.txt)
echo "sudoUserID=$sudoUserID"
cd /etc/springb0ard/
sudo rm -r Springb0ard
git clone https://github.com/LanceTreyark/Springb0ard.git
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/
cp -a /etc/springb0ard/vArsLog/$backupFile/. /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/ 
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
echo "$(date) !!! Springb0ard Files Recovered !!!" >> /etc/springb0ard/springb0ardUpdate.log