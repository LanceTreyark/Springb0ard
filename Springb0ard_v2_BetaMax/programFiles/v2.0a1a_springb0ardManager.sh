#!/bin/bash
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
# nano /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
# sudo chmod +x v2.0a1a_springb0ardManager.sh
# ./v2.0a1a_springb0ardManager.sh
# This script will track updates, manage the package and make upgrades available for install
#
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh # already enabled CORE FUNCTION

#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2a_installPostfix.sh
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2b_Postfix.DKIM.sh
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_basicWebServer.sh
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3b_configBasicWebServer.sh
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3c_deploySimpleLandingPage.sh

sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4e_springb0ardCronUpdate.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5a_yatSpringboardIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5b_yatGitIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_yatGitAddAcct.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1b0a_emailRootIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1c0a_gitEmailRoot.sh

# dTools
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_v0.0.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com_v0.0.sh
# Aliases
while read -r line; do
  alias_name=$(echo "$line" | cut -d'"' -f2)
  if ! grep -q "$alias_name" /home/$sudoUser/.bash_aliases; then
    echo "$line" >> /home/$sudoUser/.bash_aliases
  fi
done <<EOF
alias install-scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh"
alias scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh"
alias qscp="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh"
alias add-cron="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh"
alias add-origin="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_yatGitAddAcct.sh"
alias install-email-server="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh"
alias install-email-dkim="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh"
alias install-webserver="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh"
alias config-webserver="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh"
alias deploy-landing-page="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh"
alias dude="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh"
alias sudo-dude="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_v0.0.sh"
alias commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh"
alias sudo-commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com_v0.0.sh"
alias test416pm="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/x"
alias hi="sudo apt update && sudo apt upgrade"
alias deploy="/etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh"
alias bootmail="sudo systemctl restart dovecot && sudo systemctl restart postfix"
alias maillog="sudo nano /var/log/mail.log"
alias springb0ard="cat /home/$sudoUser/.bash_aliases"
alias springboard="cat /home/$sudoUser/.bash_aliases"
#echo 'alias newAlias="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/x"
EOF

# Crontab
# Set the path to the cron jobs file
cron_jobs_file="/etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4f_cronJobs.txt"

# Read the new cron jobs from file
while read -r line; do
  if ! crontab -l | grep -Fxq "$line"; then
    # Add the new job to the crontab
    (crontab -l 2>/dev/null; echo "$line") | crontab -
    echo "Added to the crontab: $line"
  else
    echo "Already exists in the crontab: $line"
  fi
done < "$cron_jobs_file"