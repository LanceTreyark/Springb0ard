#!/bin/bash
# nano v2.0a3b_testBasicWebServer.sh
# sudo chmod +x v2.0a3b_testBasicWebServer.sh
# ./v2.0a3b_testBasicWebServer.sh
echo "The script is live!"
# --Purpose: To re-create failure conditions.
# This will be run after minor root to create a standard apache site without email.

# First thing to do is add the data for our site without springb0ard.

#read -p "Please enter the domain name to use for this website, Don't add the 'www., mail. or smtp.' just the domain:   " webDomainName
webDomainName="archiveninja.com"
#read -p "Enter your Administrative email to use for SSL Certification:   " webAdminEmail
webAdminEmail="info@treyark.com"
echo ""

echo ""
echo "The following script installs an Apache webserver, a UFW Firewall, opens the necessary WWW ports"
echo "& installs Certbot a SSL Certificate generator."
echo ""
echo ""
echo "Installing Uncomplicated Firewall, this may already be installed..."
sudo apt install ufw -y
echo " "
echo "Allow WWW ports 443 and 80"
sudo ufw allow in "WWW Full"
echo " "
echo "Check UFW Status:"
sudo ufw status
echo " "
echo "Installing Apache Webserver..."
sudo apt install apache2 -y
echo " "
echo "Installing dependencies for certbot"
echo ""
echo "+ Snap D"
sudo apt install snapd
echo " "
echo "+ Snap Core"
sudo snap install core
echo " "
echo "Refresh Snap Core"
sudo snap refresh core
echo " "
echo "Installing Certbot"
sudo snap install --classic certbot -y
echo " "
echo "Adding symbolic link for Certbot"
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo "Installing apache plugin..."
sudo service apache2 reload
sudo apt install python3-certbot-apache -y


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
sudo certbot --apache -d $webDomainName -d www.$webDomainName
echo " "
echo "Restarting Apache..."
sudo systemctl restart apache2
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
sudo cp -a /tmp/htmlSamplePage/. /var/www/$webDomainName/public_html/
echo "The script has concluded, go ahead and check $webDomainName"