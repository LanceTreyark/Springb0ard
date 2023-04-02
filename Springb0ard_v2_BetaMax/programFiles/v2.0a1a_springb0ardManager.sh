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
echo "-----------------------------"
# nano v2.0a1a_springb0ardManager.sh
# sudo chmod +x v2.0a1a_springb0ardManager.sh
# ./v2.0a1a_springb0ardManager.sh
# This script will track updates, manage the package and make upgrades available for install
#append >> 
#replace >
## add alias: via append to file 
# echo 'alias newAlias="sh /etc/springb0ard/programFiles/v2.0a1a_springb0ardManager2.sh"' >> /home/$sudoUser/.bash_aliases
<<comment
This is a script that makes all scripts in the git directory executable and add their aliases to the alias file.
crontab will run this script to manage updates. 
crontab will run git pull, then this script, as this changes all new aliases and sudo chmod +X commands will be in here.
#
# For every new script added to the repo after the inital install they will need installers that make them executable
# and add aliases to whatever needs it
comment
# programFiles
# sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/
#sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh # CORE FUNCTION
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2a_installPostfix.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2b_Postfix.DKIM.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_basicWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3b_configBasicWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3c_deploySimpleLandingPage.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5a_yatSpringboardIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5b_yatGitIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_yatGitAddAcct.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1b0a_emailRootIni.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1c0a_gitEmailRoot.sh
# dTools
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_v0.0.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com_v0.0.sh
# Aliases >> append to existing file



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
alias sudo-commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/SQ_Com_v0.0.sh"
#echo 'alias newAlias="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/x"
EOF




<<comment
echo 'alias install-scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias qscp="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias add-cron="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias add-origin="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_yatGitAddAcct.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias install-email-server="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias install-email-dkim="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias install-webserver="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias config-webserver="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias deploy-landing-page="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias dude="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias sudo-dude="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_v0.0.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias sudo-commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/SQ_Com_v0.0.sh"' >> /home/$sudoUser/.bash_aliases
#echo 'alias newAlias="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/x"' >> /home/$sudoUser/.bash_aliases



while read -r line; do
  alias_name=$(echo "$line" | cut -d'"' -f2)
  if ! grep -q "$alias_name" /home/$sudoUser/.bash_aliases; then
    echo "$line" >> /home/$sudoUser/.bash_aliases
  fi
done <<EOF
echo 'alias install-scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias qscp="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias add-cron="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias add-origin="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_yatGitAddAcct.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias install-email-server="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias install-email-dkim="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias install-webserver="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias config-webserver="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias deploy-landing-page="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias dude="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias sudo-dude="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_v0.0.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh"' >> /home/$sudoUser/.bash_aliases
echo 'alias sudo-commit="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/SQ_Com_v0.0.sh"' >> /home/$sudoUser/.bash_aliases
#echo 'alias newAlias="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/x"' >> /home/$sudoUser/.bash_aliases
EOF
comment




