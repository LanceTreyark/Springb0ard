#!/bin/bash
# nano v2.0a1a_springb0ardManager.sh
# sudo chmod +x v2.0a1a_springb0ardManager.sh
# ./v2.0a1a_springb0ardManager.sh

# This script will track updates, manage the package and make upgrades available for install

<<comment
echo "Create basic Alias commands to run updates in /home/$sudoUser/ directory"
cat >/home/$sudoUser/.bash_aliases <<EOF
alias hi="sudo apt update && sudo apt upgrade"
alias deploy="sh /etc/springb0ard/programFiles/v2.0a2a_installPostfix.sh"
alias bootmail="sudo systemctl restart dovecot && sudo systemctl restart postfix"
alias maillog="sudo nano /var/log/mail.log"
alias springb0ard="cat /home/$sudoUser/.bash_aliases"
alias springboard="cat /home/$sudoUser/.bash_aliases"
EOF
sleep 1
echo "Enable the Alias file"
sudo chmod +x /home/$sudoUser/.bash_aliases
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.ssh/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/.bash_aliases
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

#Add program file:
curl -o /tmp/v2.0a1a_springb0ardManager2.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager2.sh"
sudo chmod +x /tmp/v2.0a1a_springb0ardManager2.sh
sudo mv /tmp/v2.0a1a_springb0ardManager2.sh /etc/springb0ard/programFiles/

# add alias: via append to file 
echo 'alias newAlias="sh /etc/springb0ard/programFiles/v2.0a1a_springb0ardManager2.sh"' >> /home/$sudoUser/.bash_aliases
comment