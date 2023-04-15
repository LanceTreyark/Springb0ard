#!/bin/bash
# This is for running tests 
# you can execute or edit this script with these alias commands:
# sb-test         --Run test script
# sb-etest        --Edit test script



echo "THIS TEST IS PART OF v2.0a6a_at2InstallPostfix.sh"
read -p "Please enter the domain name:   " webDomainName
webDomainName="certloop.com"
echo "Checking for the existence of apache web server..."
# Check if Apache is installed using dpkg
if dpkg -s apache2 >/dev/null 2>&1; then
  #echo "Apache is installed (checked using 'dpkg' command)."
  apacheDpkgTest="1"
else
  apacheDpkgTest="0"
fi

  # Check if Apache is installed using which
if which apache2 >/dev/null 2>&1; then
  #echo "Apache2 is installed (checked using 'which' command)."
  apacheWhichTest="1"
else
  apacheWhichTest="0"
fi  

if [ -x "$(command -v apache2)" ]; then
    #echo "Apache is installed & executable (checked using 'dpkg' and 'which' commands)."
    apacheExeTest="1"
else    
    #echo "Apache is not installed & executable (checked using 'dpkg' and 'which' commands)."
    apacheExeTest="0"
fi


# Check if Apache is active using systemctl
if systemctl is-active --quiet apache2; then
  #echo "Apache is active (checked using 'systemctl' command)."
  apacheSystemCtlTest="1"
else
  #echo "Apache is not active (checked using 'systemctl' command)."
  #exit 1
  apacheSystemCtlTest="0"  
fi

if [ $((apacheDpkgTest + apacheWhichTest + apacheExeTest + apacheSystemCtlTest)) -ge 1 ]; then
  echo "Apache was detected"
else
  echo "Apache not found"
  echo ""
  #echo "Checking for the existence of Nginx web server..."
  echo "This system is currently designed around and dependent on the Apache2 webServer"
  read -p "Would you like to install Apache2? y/n:   " checkApacheInstallPref
  if [ "$checkApacheInstallPref" = "y" ] || [ "$checkApacheInstallPref" = "Y" ]; then
    echo "Installing Apache Webserver..."
    sudo apt install apache2 -y
  fi  
fi  
# Apache should now exist either it was already installed or it was just installed



# Check if config file is present
configFile="/etc/apache2/sites-available/${webDomainName}.conf"
if [ ! -f "$configFile" ]; then
  echo "Config file for domain '$webDomainName' not found. Please create a config file before obtaining SSL certificate."
  #exit 1
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
      ServerAlias mail.$webDomainName
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
  echo "Enable Website"
  sudo a2ensite $webDomainName.conf
  echo " "
  echo "Restart Apache"
  sudo systemctl restart apache2
else
  echo "an apache config file for $webDomainName was located"  
  echo "-------------------------------------------------------------"
  sudo cat /etc/apache2/sites-available/$webDomainName.conf
  echo "-------------------------------------------------------------"
  echo "Ammending the config file with an additional alias mail.$webDomainName"
  sudo sed -i "/ServerAlias/a ServerAlias mail.$webDomainName" /etc/apache2/sites-available/$webDomainName.conf
  echo ""
  echo "Here is the ammended config file:"
  echo "-------------------------------------------------------------"
  sudo cat /etc/apache2/sites-available/$webDomainName.conf
  echo "-------------------------------------------------------------"
  echo "Verifying that the site is enabled..."
  echo "Verify permissions for the Web directory..."
  sudo chown -R www-data:www-data /var/www/$webDomainName/public_html
  echo " "
  echo "Verify the website is enabled..."
  sudo a2ensite $webDomainName.conf
  echo " "
  echo "Restarting Apache"
  sudo systemctl restart apache2
fi
# Now at this point we have apache configured and ready to obtain an ssl certificate 
# but, is certbot installed?

echo "Checking for the existence of Certbot..."
# Check if Certbot is installed using dpkg
if dpkg -s certbot >/dev/null 2>&1; then
  certbotDpkgTest="1"
else
  certbotDpkgTest="0"
fi

# Check if Certbot is installed using which
if which certbot >/dev/null 2>&1; then
  certbotWhichTest="1"
else
  certbotWhichTest="0"
fi  

# Check if Certbot is executable using command -v
if [ -x "$(command -v certbot)" ]; then
    certbotExeTest="1"
else    
    certbotExeTest="0"
fi

# Check if Certbot is active using systemctl
if systemctl is-active --quiet certbot; then
  certbotSystemCtlTest="1"
else
  certbotSystemCtlTest="0"  
fi

if [ $((certbotDpkgTest + certbotWhichTest + certbotExeTest + certbotSystemCtlTest)) -ge 1 ]; then
  echo "Certbot was detected"
else
  echo "Certbot not found"
  echo ""
  read -p "Would you like to install Certbot? y/n:   " checkCertbotInstallPref
  if [ "$checkCertbotInstallPref" = "y" ] || [ "$checkCertbotInstallPref" = "Y" ]; then
    echo "Installing Certbot..."
    #sudo apt install certbot -y
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
    sudo snap install --classic certbot
    echo " "
    echo "Adding symbolic link for Certbot"
    sudo ln -s /snap/bin/certbot /usr/bin/certbot
    echo "Installing apache plugin..."
    sudo service apache2 reload
    sudo apt install python3-certbot-apache -y
    sudo systemctl restart apache2
  fi
fi

# now that certbot is installed we need to make sure the proper ports are forwarded through the firewall, but
# do we even have a firewall? 

echo "Checking for the existence of ufw..."

# Check if ufw is installed using dpkg
if dpkg -s ufw >/dev/null 2>&1; then
  ufwDpkgTest="1"
else
  ufwDpkgTest="0"
fi

# Check if ufw is installed using which
if which ufw >/dev/null 2>&1; then
  ufwWhichTest="1"
else
  ufwWhichTest="0"
fi  

# Check if ufw is executable using command -v
if [ -x "$(command -v ufw)" ]; then
    ufwExeTest="1"
else    
    ufwExeTest="0"
fi

# Check if ufw is active using systemctl
if systemctl is-active --quiet ufw; then
  ufwSystemCtlTest="1"
else
  ufwSystemCtlTest="0"  
fi

if [ $((ufwDpkgTest + ufwWhichTest + ufwExeTest + ufwSystemCtlTest)) -ge 1 ]; then
  echo "ufw was detected"
  echo "opening WWW ports..."
  sudo ufw allow in "WWW Full"
else
  echo "ufw not found"
  echo ""
  read -p "Would you like to install ufw? y/n:   " checkUfwInstallPref
  if [ "$checkUfwInstallPref" = "y" ] || [ "$checkUfwInstallPref" = "Y" ]; then
    echo "Installing ufw..."
    sudo apt install ufw -y
    echo "opening WWW ports..."
    sudo ufw allow in "WWW Full"    
  fi
fi

# Run Certbot to obtain SSL certificate
read -p "Are you ready to deploy an ssl certificate for your webserver  y/n:   " checkCertInstallPref
#if [ "$checkCertInstallPref" = "y" -o "$checkCertInstallPref" = "Y" ]; then
if [ "$checkCertInstallPref" = "y" ] || [ "$checkCertInstallPref" = "Y" ]; then
  echo "running: certbot --apache -d $webDomainName"
  sudo certbot --apache -d $webDomainName -d www.$webDomainName -d mail.$webDomainName 
else
  echo "Skipping SSL certificate generation"
  echo ""
fi
echo "Goodbye"  
<<comment
echo "closing unused mail ports..."
#sudo ufw allow 25
sudo ufw delete allow 143
sudo ufw delete allow 110
sudo ufw delete allow 554
#sudo ufw allow "WWW Full"
sudo ufw delete allow 993
#sudo ufw allow 995
sudo ufw delete allow 587
sudo ufw status


#end

sudoUser=$(who am i | awk '{print $1}')
echo "sudoUser=$sudoUser"


if which postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'which' command)."
  postfixWhichTest="1"
else
  echo "Postfix is not installed (checked using 'which' command)."
  postfixWhichTest="0"
fi

if dpkg -s postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'dpkg' command)."
  postfixDpkgTest="1"
else
  echo "Postfix is not installed (checked using 'dpkg' command)."
  postfixDpkgTest="0" 
fi

if systemctl is-active --quiet postfix; then
  echo "Postfix is installed and active (checked using systemctl command)."
  postfixSystemctlTest="1"
else
  echo "Postfix is not installed or inactive (checked using systemctl command)."
  postfixSystemctlTest="0"
fi

if which dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'which' command)."
  dovecotWhichTest="1"
else
  echo "Dovecot is not installed (checked using 'which' command)."
  dovecotWhichTest="0"

fi

if dpkg -s dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'dpkg' command)."
  dovecotDpkgTest="1"
else
  echo "Dovecot is not installed (checked using 'dpkg' command)."
  dovecotDpkgTest="0"
fi

if systemctl is-active --quiet dovecot; then
  echo "Dovecot is installed and active (checked using systemctl command)."
  dovecotSystemctlTest="1"
else
  echo "Dovecot is not installed or inactive (checked using systemctl command)."
  dovecotSystemctlTest="0"
fi

if which git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'which' command)."
  gitWhichTest="1"
else
  echo "Git is not installed (checked using 'which' command)."
  gitWhichTest="0"
fi

if dpkg -s git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'dpkg' command)."
  gitDpkgTest="1"
else
  echo "Git is not installed (checked using 'dpkg' command)."
  gitDpkgTest="0"
fi

echo "postfixWhichTest=$postfixWhichTest"
echo "postfixDpkgTest=$postfixDpkgTest"
echo "postfixSystemctlTest=$postfixSystemctlTest"
echo "dovecotWhichTest=$dovecotWhichTest"
echo "dovecotDpkgTest=$dovecotDpkgTest"
echo "dovecotSystemctlTest=$dovecotSystemctlTest"
echo "gitWhichTest=$gitWhichTest"
echo "gitDpkgTest=$gitDpkgTest"

if [ $((postfixWhichTest + postfixDpkgTest + postfixSystemctlTest)) -ge 1 ]; then
  echo "Postfix is currently installed on this system"
  #echo "Removing previous Postfix installation ..."
  #sudo apt-get remove --purge postfix
  #sudo apt-get autoremove --purge
  #sudo apt-get clean
fi

if [ $((dovecotWhichTest + dovecotDpkgTest + dovecotSystemctlTest)) -ge 1 ]; then
  echo "Dovecot is currently installed on this system"
  #echo "Removing previous Dovecot installation..."
  #sudo apt-get remove --purge dovecot
  #sudo apt-get autoremove --purge
  #sudo apt-get clean
fi
comment