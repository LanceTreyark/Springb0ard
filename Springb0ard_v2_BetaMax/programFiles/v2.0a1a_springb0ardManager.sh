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

comment
# programFiles
# sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a1a_springb0ardManager.sh 
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2a_installPostfix.sh # Depreciated
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a2b_Postfix.DKIM.sh # Depreciated
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3a_basicWebServer.sh # Depreciated
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3b_configBasicWebServer.sh # Depreciated
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a3c_deploySimpleLandingPage.sh # Depreciated
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4a_addScp3r.sh # Depreciated? if not # alias= install-scp3r
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh # alias= scp3r
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh # alias= qscp
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4d_cronTabAutomation.sh # alias= addcron
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5a_yatSpringboardIni.sh # CORE FUNCTION
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5b_yatGitIni.sh # CORE FUNCTION
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5c_yatGitAddAcct.sh # alias= add-git-origin
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7a_gitInstallPostfix.sh # alias= install-email-server
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7c_gitBasicWebServer.sh # alias= install-webserver
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7d_gitConfigBscWebServer.sh #alias= config-webserver
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7e_gitDeployLandingPage.sh # alias= deploy-landing-page
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1b0a_emailRootIni.sh
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.1c0a_gitEmailRoot.sh

# dTools
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_i1.sh  
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/microInit_v0.0.sh
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/Q_Com.sh
sudo chmod +x cd /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/dTools/SQ_Com_v0.0.sh  

echo 'alias newAlias="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/x"' >> /home/$sudoUser/.bash_aliases

