#!/bin/bash
# nano v2.0a7f_DeployWebsiteV3.sh
# sudo chmod +x v2.0a7f_DeployWebsiteV3.sh
# ./v2.0a7f_DeployWebsiteV3.sh
#

echo "The following script configures an Apache webserver to deploy a new webpage "
echo "for a given domain name you provide, in addition it provides an SSL certificate."
d=""
existingSubDomain=""
echo ""
read -p "What is the domain name? (ie: example.com):   " webDomainName
echo ""
read -p "What is your administrative email?:   " webAdminEmail
echo ""
echo "Creating a site directory for $webDomainName"
sudo mkdir -p /var/www/$webDomainName/public_html
echo "-----------------------------------------------"
ls /var/www/
echo "-----------------------------------------------"
ls /var/www/$webDomainName
echo "-----------------------------------------------"
echo " "
echo "Create Apache2 configuration file"
cat > /tmp/$webDomainName.conf <<EOF
<VirtualHost *:80>
    ServerAdmin $webAdminEmail
    ServerName $webDomainName
    ServerAlias www.$webDomainName
    #ServerAlias mail.$webDomainName
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
echo "Moving config file to /etc/apache2/sites-available/"
sudo mv /tmp/$webDomainName.conf /etc/apache2/sites-available/
echo "config file check in /etc/apache2/sites-available"
echo "--------------------------------------------"
sudo ls /etc/apache2/sites-available
echo "--------------------------------------------"
echo " "
echo "Configure permissions for the Web directory"
sudo chown -R www-data:www-data /var/www/$webDomainName/public_html
echo " "
echo "Enable Website and Obtain SSL Certificate"
sudo a2ensite $webDomainName.conf
echo " "
echo "Restart Apache"
sudo systemctl restart apache2
echo " "
echo "Obtain SSL Certificate"
sudo certbot --apache -d $webDomainName -d www.$webDomainName $d $existingSubDomain 
echo " "
echo "Restarting Apache..."
sudo systemctl restart apache2
echo "The script has concluded."
echo "Preparing to deploy landing page..."
mkdir /tmp/htmlSamplePage
echo "Creating a Sample page in the web directory for $webDomainName"
curl -o /tmp/htmlSamplePage/index.html https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/index.html
curl -o /tmp/htmlSamplePage/styles.css https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/styles.css
curl -o /tmp/htmlSamplePage/robots.txt https://raw.githubusercontent.com/LanceTreyark/sampleLandingPage/main/robots.txt
echo "Moving the files to the web directory"
sudo cp -a /tmp/htmlSamplePage/. /var/www/$webDomainName/public_html/
echo "The script has concluded, go ahead and check $webDomainName"