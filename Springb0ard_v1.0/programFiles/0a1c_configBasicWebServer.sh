#!/bin/bash

#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# nano 0a1c_configBasicWebServer.sh
# sudo chmod +x 0a1c_configBasicWebServer.sh
# ./0a1c_configBasicWebServer.sh

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
sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/vArs/mailDomain.txt)

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
#----------------------------------------------------

sleep 1
echo ""
echo "The following script configures an Apache webserver "
echo "for a given domain name you provide, in addition it provides an SSL."
echo "certificate."
sleep 2
echo ""
#
d="-d"
existingSubDomain="mail.$webDomainName"
#
#read -p "Please enter the domain name to use for this new site, Don't add the 'www':   " webDomainName
#echo " "
#read -p "Enter your Administrative email to use for SSL Certification:   " webAdminEmail
#echo " "
#echo " "
#echo "If you have an existing subdomain for this same domain like 'mail.example.com', you can" 
#echo "enter that here to group everything under the same certificate"
#echo ""
#read -p "Do you have an existing subdomain with SSL certificate? [y/n] " has_ssl

#if [[ $has_ssl =~ ^[Yy]$ ]]; then
  # If user has SSL, ask for the subdomain name
#  read -p "Enter existing subdomain name: " existing_subdomain

  # Set variables accordingly
#  d="-d"
#  existingSubDomain="$existing_subdomain"
#else
  # If user doesn't have SSL, set variables to empty
#  d=""
#  existingSubDomain=""
#fi
#
# Use variables in your script as needed
#echo "d=$d"
#echo "existingSubDomain=$existingSubDomain"
#

echo "Creating a site directory for $webDomainName"
sudo mkdir -p /var/www/$webDomainName/public_html
sleep 1
echo " "
echo "Create Apache2 configuration file"
#cat >/etc/apache2/sites-available/$webDomainName.conf <<EOF
cat >/tmp/$webDomainName.conf <<EOF
<VirtualHost *:80>
    ServerAdmin $webAdminEmail
    ServerName $webDomainName
    ServerAlias www.$webDomainName
    DocumentRoot /var/www/$webDomainName/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
  <Directory /var/www/$webDomainName/public_html/>
          AllowOverride All
  </Directory>
</VirtualHost>
EOF
sudo mv /tmp/$webDomainName.conf /etc/apache2/sites-available/
sleep 1
echo " "
echo "Configure permissions for the Web directory"
sudo chown -R www-data:www-data /var/www/$webDomainName/public_html
sleep 1
echo " "
echo "Enable Website and Obtain SSL Certificate"
sudo a2ensite $webDomainName.conf
sleep 1
echo " "
echo "Restart Apache"
sudo systemctl restart apache2
sleep 1
echo " "
echo "Obtain SSL Certificate"
sudo certbot --apache $d $existingSubDomain -d $webDomainName -d www.$webDomainName
sleep 1
echo " "
echo "Restarting Apache..."
sudo systemctl restart apache2
echo "The script has concluded."
echo "bye"
sh /etc/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh
