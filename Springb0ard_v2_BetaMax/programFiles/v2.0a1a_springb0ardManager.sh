#!/bin/bash
# nano v2.0a1a_springb0ardManager.sh
# sudo chmod +x v2.0a1a_springb0ardManager.sh
# ./v2.0a1a_springb0ardManager.sh

# This script will track updates, manage the package and make upgrades available for install

<<comment

echo "Installing Springb0ard"
curl -o /tmp/springb0ard/programFiles/v2.0a1a_springb0ardManager.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a2a_installPostfix.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a2a_installPostfix.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a2b_Postfix.DKIM.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a2b_Postfix.DKIM.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a3a_basicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_basicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a3b_configBasicWebServer.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a3b_configBasicWebServer.sh"
curl -o /tmp/springb0ard/programFiles/v2.0a3c_deploySimpleLandingPage.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a3c_deploySimpleLandingPage.sh"
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a1a_springb0ardManager.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a2a_installPostfix.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a3a_basicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a3b_configBasicWebServer.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a3c_deploySimpleLandingPage.sh
sudo chmod +x /tmp/springb0ard/programFiles/v2.0a2b_Postfix.DKIM.sh
sudo cp -r /tmp/springb0ard /etc/
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard



#append >> 
#replace >

## Add program file:
curl -o /tmp/v2.0a1a_springb0ardManager2.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager2.sh"
sudo chmod +x /tmp/v2.0a1a_springb0ardManager2.sh
sudo mv /tmp/v2.0a1a_springb0ardManager2.sh /etc/springb0ard/programFiles/

## add alias: via append to file 
echo 'alias newAlias="sh /etc/springb0ard/programFiles/v2.0a1a_springb0ardManager2.sh"' >> /home/$sudoUser/.bash_aliases
comment

<<comment
This is a script that makes all scripts in the git directory executable and add their aliases to the alias file.
crontab will run this script to manage updates. 
crontab will run git pull, then this script, as this changes all new aliases and sudo chmod +X commands will be in here.

comment

