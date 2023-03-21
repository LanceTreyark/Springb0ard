#!/bin/bash

#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# nano 0a1d_deploySimpleLandingPage.sh
# sudo chmod +x 0a1d_deploySimpleLandingPage.sh
# ./0a1d_deploySimpleLandingPage.sh

<<comment
* TITLE:  0a1c_configBasicWebServer.sh
* AUTHOR: Lance Pierson
* EMAIL:  info@treyark.com
* DATE:   3/14/23
* EXECUTIVE SUMMARY: 
* UNIT TEST RESULT: 
comment

echo "The script is live!"

#Call your vArs!
yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)


sleep 1
echo ""
echo "The following script deploys a basic landing page for your site"
#echo "It is assumed that you have already run '0a1c_configBasicWebServer.sh' and the site is enabled w/ a proper directory"
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
echo "bye"