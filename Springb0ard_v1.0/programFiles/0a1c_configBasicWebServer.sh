#!/bin/bash
# !!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## nano 0a1c_configBasicWebServer.sh
## sudo chmod +x 0a1c_configBasicWebServer.sh
## ./0a1c_configBasicWebServer.sh
echo "The script is live!"
echo "no sleep"
# Call your vArs!
yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/vArs/mailDomain.txt)
d="-d"
existingSubDomain="mail.$mailDomain"
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
echo ""
echo "$existingSubDomain"
echo "$d"
echo "-----------------------------"
#----------------------------------------------------
#
echo ""
echo "The following script configures an Apache webserver "
echo "for a given domain name you provide, in addition it provides an SSL."
echo "certificate."
echo ""
echo "Creating a site directory for $webDomainName"
sudo mkdir -p /var/www/$webDomainName/public_html
echo "-----------------------------------------------"
ls /var/www/
echo "-----------------------------------------------"
ls /var/www/$webDomainName
echo "-----------------------------------------------"
echo " "
#
echo "Create Apache2 configuration file"
cat > /tmp/$webDomainName.conf <<EOF
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
echo "verify that config file was created in tmp dir:"
echo "--------------------------------------------"
cat /tmp/$webDomainName.conf
echo "--------------------------------------------"
#
echo "Moving config file to /etc/apache2/sites-available/"
sudo mv /tmp/$webDomainName.conf /etc/apache2/sites-available/
echo "config file check in /etc/apache2/sites-available"
echo "--------------------------------------------"
sudo ls /etc/apache2/sites-available
echo "--------------------------------------------"
#
#sleep 1
echo " "
echo "Configure permissions for the Web directory"
sudo chown -R www-data:www-data /var/www/$webDomainName/public_html
#sleep 1
#
echo " "
echo "Enable Website and Obtain SSL Certificate"
sudo a2ensite $webDomainName.conf
#sleep 1
echo " "
echo "Restart Apache"
sudo systemctl restart apache2
#sleep 1
echo " "
#
echo "Obtain SSL Certificate"
sudo certbot --apache $d $existingSubDomain -d $webDomainName -d www.$webDomainName
#sleep 1
echo " "
echo "Restarting Apache..."
sudo systemctl restart apache2
echo "The script has concluded."
echo "Next,"
echo "sh /etc/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh"
#read -p "Press Enter to continue" meh
sh /etc/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh