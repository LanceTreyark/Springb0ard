#!/bin/bash
# Git Core: Yes
# nano v2.0a6a_at2InstallPostfix.sh
# sudo chmod +x v2.0a6a_at2InstallPostfix.sh
# ./v2.0a6a_at2InstallPostfix.sh
#
#sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a6a_at2InstallPostfix.sh

# Purpose this will probably replace 0a5d
# This version swaps the standalone cert with a cert amendment to a config file.

# How?

# run a test to locate an apache config file for the name in question

#
echo "The script is live!"
echo ""
read -p "Please enter the domain name to use for this mailserver, Don't add the 'www., mail. or smtp.' just the domain:   " mailDomain
#mailDomain="example.com"
echo ""
read -p "Please create a new username for your new virtual inbound email address:   " regMailUser
#regMailUser="admin"
echo ""
read -p "Enter your Administrative email to use for SSL Certification:   " webAdminEmail
#webAdminEmail="name@example.com"
echo ""
echo "$webAdminEmail" > /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/webAdminEmail.txt
echo "$regMailUser" > /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/regMailUser.txt
echo "$mailDomain" > /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt
#Call your vArs!
#yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/webAdminEmail.txt)
#mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
#defaultScpAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
#scpExportPath=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt)
echo "           vArs Test:"
echo "-----------------------------"
#echo "yourDomain=$yourDomain"
echo "mailDomain=$mailDomain"
echo "regMailUser=$regMailUser"
echo "sudoUser=$sudoUser"
echo "sudoUserID=$sudoUserID"
echo "myIP=$myIP"
echo "webAdminEmail=$webAdminEmail"
echo "-----------------------------"
echo "Check the values above in order for this script to work none of these values can be blank"
read -p "Press enter to continue, or exit the script with CTRL+C" meh
echo "-----------------------------"

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
configFile="/etc/apache2/sites-available/${mailDomain}.conf"
if [ ! -f "$configFile" ]; then
  echo "Config file for domain '$mailDomain' not found."
  echo "Creating a config file for SSL certificate."
  #exit 1
  echo "Creating a site directory for $mailDomain"
  sudo mkdir -p /var/www/$mailDomain/public_html
  echo "-----------------------------------------------"
  ls /var/www/
  echo "-----------------------------------------------"
  ls /var/www/$mailDomain
  echo "-----------------------------------------------"
  echo " "
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
  echo "Moving config file to /etc/apache2/sites-available/"
  sudo mv /tmp/$mailDomain.conf /etc/apache2/sites-available/
  echo "config file check in /etc/apache2/sites-available"
  echo "--------------------------------------------"
  sudo ls /etc/apache2/sites-available
  echo "--------------------------------------------"
  echo " "
  echo "Configure permissions for the Web directory"
  sudo chown -R www-data:www-data /var/www/$mailDomain/public_html
  echo " "
  echo "Enable Website"
  sudo a2ensite $mailDomain.conf
  echo " "
  echo "Restart Apache"
  sudo systemctl restart apache2
else
  echo "an apache config file for $mailDomain was located"  
  echo "Verifying that the site is enabled..."
  echo "Verify permissions for the Web directory..."
  sudo chown -R www-data:www-data /var/www/$mailDomain/public_html
  echo " "
  echo "Verify the website is enabled..."
  sudo a2ensite $mailDomain.conf
  echo " "
  echo "Restarting Apache"
  sudo systemctl restart apache2
fi

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
  fi
fi

echo "Opening required mail ports..."
sudo ufw allow 25
#sudo ufw allow 143
#sudo ufw allow 110
sudo ufw allow 554
sudo ufw allow "WWW Full"
#sudo ufw allow 993
sudo ufw allow 995
#sudo ufw allow 587
sudo ufw status
echo "Adding new user $regMailUser"
sudo adduser $regMailUser
echo "Next we will set up the server name and IP so that the Mail DNS is in order..."
sudo hostname mail.$mailDomain
hostName=$(hostname)
echo "The Hostname for this server is set to $hostName"
echo ""
echo "We are going to add the domain name to the hosts file"
echo "here is the file currently:"
echo "------------------------------------------------------"
sudo cat /etc/hosts
echo "------------------------------------------------------"
echo "Ammending to '127.0.0.1 localhost mail.$mailDomain'"
sudo sed -i "/127.0.0.1/a $myIP mail.$mailDomain" /etc/hosts
echo ""
echo "Here is the amended file:"
echo "------------------------------------------------------"
sudo cat /etc/hosts
echo "------------------------------------------------------"
echo ""
echo "setting up Pre-Seeding Parameters for automatic postfix installation..."
echo "before seed file in /tmp"
ls -a -1 /tmp/
touch /tmp/postfix.seed
echo "After seed file in /tmp"
ls -a -1 /tmp/
echo "postfix postfix/main_mailer_type string 'Internet Site'" >> /tmp/postfix.seed
echo "postfix postfix/mailname string $mailDomain" >> /tmp/postfix.seed
echo "/var/cache/debconf/ before mv"
sudo ls -a -1 /var/cache/debconf/
sudo mv /tmp/postfix.seed /var/cache/debconf/
echo "/var/cache/debconf/ After file mv"
echo "verify contents"
sudo cat /var/cache/debconf/postfix.seed
########################
# Postfix Installation #
########################
echo "Install & Preconfigure Postfix"
sudo debconf-set-selections /var/cache/debconf/postfix.seed
sudo apt install postfix -y
echo "making a default copy of postfix"
sudo cp -r /etc/postfix /home/$sudoUser/
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/postfix
echo "Configuring Postfix..."
sudo postconf -e 'home_mailbox = Maildir/'
sudo postconf -e "mydomain = $mailDomain"

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

<<comment
This new SSL certification method ammends an existing certificate or combines everything into on cert
without subdomains. This script has been modified to remove the mail.example.com subdomain from our 
certificate path declarations.
comment
echo ""
echo "your DNS needs to look like the following before proceeding:"
echo "Where I use '@' below you will see $mailDomain when It's been entered correctly into DNS"
echo "| TYPE.........HOST.............ANSWER................................TTL......PRIO |"
echo "| A              @               $myIP                        300       N/A |"
echo "| A             WWW              $myIP                        300       N/A |"
echo "| A             mail             $myIP                        300       N/A |"
echo "| MX             @               mail.$mailDomain                  300       N/A |" 
echo "-------------------------------------------------------------------------------------"
read -p "Make sure you have your DNS ready then press enter to continue" xVar
#
echo "Installing SSL certificate via Certbot..."
sudo certbot --apache -d $mailDomain -d www.$mailDomain -d mail.$mailDomain 
#
sudo postconf -e "smtpd_tls_cert_file = /etc/letsencrypt/live/$mailDomain/fullchain.pem"
sudo postconf -e "smtpd_tls_key_file = /etc/letsencrypt/live/$mailDomain/privkey.pem"
echo "installing Dovecot"
sudo apt install dovecot-common dovecot-imapd dovecot-pop3d -y 
sudo cp -r /etc/dovecot /home/$sudoUser/
sudo chown -R $sudoUser:$sudoUser /home/$sudoUser/dovecot
sudo postconf -e 'smtpd_sasl_type = dovecot'
sudo postconf -e 'smtpd_sasl_path = private/auth'
sudo postconf -e 'smtpd_sasl_local_domain ='
sudo postconf -e 'smtpd_sasl_security_options = noanonymous'
sudo postconf -e 'broken_sasl_auth_clients = yes'
sudo postconf -e 'smtpd_sasl_auth_enable = yes'
sudo postconf -e 'smtpd_recipient_restrictions = permit_sasl_authenticated,permit_mynetworks,reject_unauth_destination'
sudo postconf -e 'smtp_tls_security_level = may'
sudo postconf -e 'smtpd_tls_security_level = may'
sudo postconf -e 'smtp_tls_note_starttls_offer = yes'
sudo postconf -e 'smtpd_tls_loglevel = 1'
sudo postconf -e 'smtpd_tls_received_header = yes'
sudo postconf -e 'mydestination = $mydomain, $myhostname, localhost.$myhostname, localhost'
sudo postconf -e "myhostname = mail.$mailDomain"
sudo postconf -e 'virtual_alias_maps = hash:/etc/postfix/virtual'
sudo postconf -e 'sender_canonical_maps = regexp:/etc/postfix/sender_canonical'
sudo postconf -e 'smtpd_banner = $myhostname ESMTP $mail_name'
touch /tmp/sender_canonical
echo "/$regMailUser@mail.$mailDomain/ $regMailUser@$mailDomain" >> /tmp/sender_canonical
sudo cp /tmp/sender_canonical /etc/postfix/
sudo postmap /etc/postfix/sender_canonical
touch /tmp/virtual
echo "postmaster@$mailDomain root" >> /tmp/virtual
echo "root@$mailDomain root" >> /tmp/virtual
echo "info@$mailDomain info" >> /tmp/virtual
echo "$sudoUser@$mailDomain $sudoUser $regMailUser@$mailDomain" >> /tmp/virtual
sudo cp /tmp/virtual /etc/postfix/ 
sudo postmap /etc/postfix/virtual
sudo sed -i "/#smtps     inet  n       -       y       -       -       smtpd/a smtps     inet  n       -       y       -       -       smtpd" /etc/postfix/master.cf
sudo systemctl restart postfix
sudo maildirmake.dovecot /etc/skel/Maildir
sudo maildirmake.dovecot /etc/skel/Maildir/.Drafts
sudo maildirmake.dovecot /etc/skel/Maildir/.Sent
sudo maildirmake.dovecot /etc/skel/Maildir/.Trash
sudo maildirmake.dovecot /etc/skel/Maildir/.Templates
sudo cp -r /etc/skel/Maildir /home/$regMailUser/
sudo cp -r /etc/skel/Maildir /home/$sudoUser/
uid=$(id -u "$regMailUser")
sudo chown -R $uid:$uid /home/$regMailUser/Maildir
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/Maildir
sudo chmod -R 700 /home/$regMailUser/Maildir
sudo adduser $regMailUser mail
echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
echo "Phase 1 Postfix configuration is complete"
########################
# Dovecot Installation #
########################
echo "Starting Dovecot Installation..."
echo "Editing /etc/dovecot/conf.d/10-auth.conf..."
echo "Disable the plaintext authentication & enable the login authentication mechanism"
echo ""
sleep 0.5
echo "disable_plaintext_auth = yes"
echo "..."
echo "auth_mechanisms = plain login"
sudo sed -i "/#disable_plaintext_auth = yes/a disable_plaintext_auth = no" /etc/dovecot/conf.d/10-auth.conf
sudo sed -i "s/auth_mechanisms = plain/#auth_mechanisms = plain/" /etc/dovecot/conf.d/10-auth.conf
sudo sed -i "/#auth_mechanisms = plain/a auth_mechanisms = plain login" /etc/dovecot/conf.d/10-auth.conf
echo ""
echo "Instruct the mail directory to use the same format as Postfix."
echo "Editing /etc/dovecot/conf.d/10-mail.conf..."
echo ""
echo "Configure the IMAP and POP3 protocols for email clients in the master.conf file "
echo ""
sudo sed -i "s/#port = 143/port = 143/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "s/#port = 110/port = 110/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "s/#unix_listener \/var\/spool\/postfix\/private\/auth {/unix_listener \/var\/spool\/postfix\/private\/auth {/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/unix_listener \/var\/spool\/postfix\/private\/auth {/a #i7" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/#i7/a }" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/#i7/a     user = postfix" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/#i7/a     group = postfix" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/#i7/a     mode = 0660" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/unix_listener lmtp {/a      mode = 0666" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/inet_listener submission {/a      port = 587" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/inet_listener pop3s {/a      ssl = yes" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/inet_listener pop3s {/a      port = 995" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/inet_listener imaps {/a      ssl = yes" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/inet_listener imaps {/a      port = 993" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/#imap_id_send =/a  imap_id_send = +OK" /etc/dovecot/conf.d/20-imap.conf
echo ""
echo "Configure  default to the standard ports, 143 for IMAP and 110 for POP3. With STARTTLS required for every connection"
echo ""
echo "sudo nano /etc/dovecot/conf.d/10-ssl.conf"
echo ""
sudo sed -i "s/#ssl_min_protocol = TLSv1/ssl_min_protocol = TLSv1/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl = yes/ssl = required/" /etc/dovecot/conf.d/10-ssl.conf
# or if thats not there do this
sudo sed -i "s/#ssl = required/ssl = required/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl_cert = <\/etc\/dovecot\/private\/dovecot.pem/ssl_cert = <\/etc\/letsencrypt\/live\/$mailDomain\/fullchain.pem/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl_key = <\/etc\/dovecot\/private\/dovecot.key/ssl_key = <\/etc\/letsencrypt\/live\/$mailDomain\/privkey.pem/" /etc/dovecot/conf.d/10-ssl.conf
echo ""
sudo sed -i "s/mail_location = mbox:~\/mail:INBOX=\/var\/mail\/%u/mail_location = maildir:~\/Maildir/" /etc/dovecot/conf.d/10-mail.conf
echo "Check the Dovecot configuration"
echo ""
sudo dovecot -n
echo ""
echo "Restart dovecot"
echo ""
sudo systemctl restart dovecot
sudo systemctl restart postfix
echo ""
echo "Install mailutils"
echo ""
sudo apt install mailutils -y 
echo ""
echo "Additional security options"
echo ""
echo "Skipping for now..."
echo ""
#sudo cat /etc/postfix/virtual
#echo "$sudoUser@$mailDomain $sudoUser $regMailUser@$mailDomain" >> /etc/postfix/virtual
sudo postmap /etc/postfix/virtual
sudo systemctl restart postfix
read -p "Press Enter to continue to DKIM generation" meh
sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a5e_atPostfix.DKIM.sh