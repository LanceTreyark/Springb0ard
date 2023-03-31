#!/bin/bash
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
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2a_installPostfix.sh # Depreciated
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2b_Postfix.DKIM.sh # Depreciated
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_basicWebServer.sh # Depreciated
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3b_configBasicWebServer.sh # Depreciated
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3c_deploySimpleLandingPage.sh # Depreciated
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh #ADDED# Depreciated? if not # alias= install-scp3r
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh #ADDED# alias= scp3r
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh #ADDED# alias= qscp
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh #ADDED# alias= add-cron
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5a_yatSpringboardIni.sh # CORE FUNCTION
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5b_yatGitIni.sh # CORE FUNCTION
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_yatGitAddAcct.sh #ADDED# alias= add-origin
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh #ADDED# alias= install-email-server
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh #ADDED# alias= install-email-dkim
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh #ADDED# alias= install-webserver
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh #ADDED# alias= config-webserver
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh #ADDED# alias= deploy-landing-page
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1b0a_emailRootIni.sh # Depreciated
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1c0a_gitEmailRoot.sh # CORE FUNCTION
# dTools
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh # alias= dude
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_v0.0.sh # alias= sudo-dude
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh # alias= commit
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/SQ_Com_v0.0.sh # alias= sudo-commit
# Aliases >> append to existing file
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