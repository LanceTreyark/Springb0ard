#!/bin/bash
# v2.0a1a_springb0ardManager.sh
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
echo "webDomainName=$webDomainName"
#echo "defaultScpAddr=$defaultScpAddr"
#echo "scpExportPath=$scpExportPath"

echo "-----------------------------"
# nano /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh
# sudo chmod +x v2.0a1a_springb0ardManager.sh
# ./v2.0a1a_springb0ardManager.sh
# This script will track updates, manage the package and make upgrades available for install
#
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh # already enabled CORE FUNCTION

sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5f_atDebian10.DKIM.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a6a_at2InstallPostfix.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5d_atInstallPostfix.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5e_atPostfix.DKIM.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_testArea.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4e_springb0ardCronUpdate.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4g_cronAptUpdate.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5a_atSpringboardIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5b_atGitIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_atGitAddAcct.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1c0a_gitEmailRoot.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1b_springb0ardRecovery.sh
cp /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1b_springb0ardRecovery.sh /etc/springb0ard/
sudo chmod +x /etc/springb0ard/v2.0a1b_springb0ardRecovery.sh
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
alias sb-mailserver="/etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a6a_at2InstallPostfix.sh"
alias sb-dkim="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5e_atPostfix.DKIM.sh"
alias sb-etest="nano /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_testArea.sh"
alias sb-test="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_testArea.sh"
alias bb="btop"
alias sb-latest="cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2b_latest.txt"
alias sb-help="cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2a_helpMenu.txt"
alias sb-log="cat /etc/springb0ard/springb0ardUpdate.log"
alias sb-recovery="sh /etc/springb0ard/v2.0a1b_springb0ardRecovery.sh"
alias sb-update="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4e_springb0ardCronUpdate.sh"
alias install-scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh"
alias scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh"
alias qscp="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh"
alias add-cron="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh"
alias add-origin="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_atGitAddAcct.sh"
alias install-email="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh"
alias install-dkim="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh"
alias install-apache="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh"
alias config-apache="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh"
alias deploy-page="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh"
alias dude="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh"
alias commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh"
alias hi="sudo apt update && sudo apt upgrade"
alias sb-deploy="/etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh"
alias bootmail="sudo systemctl restart dovecot && sudo systemctl restart postfix"
alias maillog="sudo tail -n 100 /var/log/mail.log"
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