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
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" mEh
#                 ---Pump The Brakes---"
#
echo ""
echo "The following script configures an Apache webserver "
echo "for a given domain name you provide, in addition it provides an SSL."
echo "certificate."
echo ""
echo "Creating a site directory for $mailDomain"
sudo mkdir /var/www/$mailDomain/
ls /var/www/
echo " "
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
sudo mkdir /var/www/$mailDomain/public_html
ls /var/www/$mailDomain
echo " "
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
echo "Create Apache2 configuration file"
cat > /tmp/$mailDomain.conf <<EOF
<VirtualHost *:80>
    ServerAdmin $webAdminEmail
    ServerName $mailDomain
    ServerAlias www.$mailDomain
    DocumentRoot /var/www/$mailDomain/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
  <Directory /var/www/$mailDomain/public_html/>
          AllowOverride All
  </Directory>
</VirtualHost>
EOF
echo "verify that config file was created in tmp dir:"
echo "--------------------------------------------"
cat /tmp/$mailDomain.conf
echo "--------------------------------------------"
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
echo "Moving config file to /etc/apache2/sites-available/"
sudo mv /tmp/$mailDomain.conf /etc/apache2/sites-available/
echo "config file check in /etc/apache2/sites-available"
echo "--------------------------------------------"
sudo ls /etc/apache2/sites-available
echo "--------------------------------------------"
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
#sleep 1
echo " "
echo "Configure permissions for the Web directory"
sudo chown -R www-data:www-data /var/www/$mailDomain/public_html
#sleep 1
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
echo " "
echo "Enable Website and Obtain SSL Certificate"
sudo a2ensite $mailDomain.conf
#sleep 1
echo " "
echo "Restart Apache"
sudo systemctl restart apache2
#sleep 1
echo " "
#
#                 ---Pump The Brakes---"
echo "            ---Pump The Brakes---"
read -p "Check for errors then hit enter to continue" meh
#                 ---Pump The Brakes---"
#
echo "Obtain SSL Certificate"
sudo certbot --apache $d $existingSubDomain -d $mailDomain -d www.$mailDomain
#sleep 1
echo " "
echo "Restarting Apache..."
sudo systemctl restart apache2
echo "The script has concluded."
echo "Next,"
echo "sh /etc/springb0ard/programFiles/0a1d_deploySimpleLandingPage.sh"