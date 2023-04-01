#!/bin/bash
# nano v2.0a3c_deploySimpleLandingPage.sh
# sudo chmod +x v2.0a3c_deploySimpleLandingPage.sh
# ./v2.0a3c_deploySimpleLandingPage.sh
echo "The script is live!"
#Call your vArs!
yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/vArs/mailDomain.txt)
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
echo ""
echo "The following script deploys a basic landing page for your site"
#echo "It is assumed that you have already run 'v2.0a3b_configBasicWebServer.sh' and the site is enabled w/ a proper directory"
#read -p "Press enter to proceed with the script" fgVar
#read -p "what is the domain we are creating the sample page for?" yourDomain 
echo "Creating a temp directory and using curl to copy the sample files"
echo " installing dependencies, these should already be installed..."
sudo apt install snapd -y
sudo snap install core
sudo apt install curl -y
mkdir /tmp/htmlSamplePage
curl -o /tmp/htmlSamplePage/index.html https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/index.html
curl -o /tmp/htmlSamplePage/styles.css https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/styles.css
curl -o /tmp/htmlSamplePage/robots.txt https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/robots.txt
echo "Moving the files to the web directory"
sudo cp -a /tmp/htmlSamplePage/. /var/www/$yourDomain/public_html/
echo "The script has concluded, go ahead and check $yourDomain"
echo "Preparing to deploy DKIM keys and DNS records..."
echo "Will start in 10 seconds..."
sleep 5
echo "5 Seconds..."
sleep 5
echo "sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh"
sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a7b_gitPostfix.DKIM.sh