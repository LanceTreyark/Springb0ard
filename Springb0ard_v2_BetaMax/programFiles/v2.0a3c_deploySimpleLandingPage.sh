#!/bin/bash
# nano v2.0a3c_deploySimpleLandingPage.sh
# sudo chmod +x v2.0a3c_deploySimpleLandingPage.sh
# ./v2.0a3c_deploySimpleLandingPage.sh
echo "The script is live!"
#Call your vArs!
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
sleep 1
echo ""
echo "The following script deploys a basic landing page for your site"
#echo "It is assumed that you have already run 'v2.0a3b_configBasicWebServer.sh' and the site is enabled w/ a proper directory"
#read -p "Press enter to proceed with the script" fgVar
#read -p "what is the domain we are creating the sample page for?" yourDomain 
sleep 1
echo "Creating a temp directory and using curl to copy the sample files"
echo " installing dependencies, these should already be installed..."
sudo apt install snapd -y
sudo snap install core
sudo apt install curl -y
mkdir /tmp/htmlSamplePage
curl -o /tmp/htmlSamplePage/index.html https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/index.html
curl -o /tmp/htmlSamplePage/styles.css https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/styles.css
curl -o /tmp/htmlSamplePage/robots.txt https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/robots.txt
sleep 1
echo "Moving the files to the web directory"
sudo cp -a /tmp/htmlSamplePage/. /var/www/$yourDomain/public_html/
sleep 1
echo "The script has concluded, go ahead and check $yourDomain"
echo "Next,"
echo "sh /etc/springb0ard/programFiles/v2.0a2b_Postfix.DKIM.sh"
sh /etc/springb0ard/programFiles/v2.0a2b_Postfix.DKIM.sh