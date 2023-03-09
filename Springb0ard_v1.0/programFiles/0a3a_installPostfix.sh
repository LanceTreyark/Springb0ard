#!/bin/bash

#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<<comment
* TITLE: 
* AUTHOR: LP
* DATE:

PURPOSE:

As of 3.8.23
My plan is to set this to be able to run independently as it's own program.


This is the initial Postfix configuration

1 Read input and store as var_MailDomain and var_nonSudoUser.
  A) in order to do this we need to create a program directory. If it already exists it will just be skipped.
2 Create files to store input variables in the /etc/springboard/ directory: var_MailDomain.txt and var_nonSudoUser.txt.
3 Add new user with the name var_nonSudoUser.
4 Set hostname to mail.$mailDomain. also set IP using the code we already wrote...
5 Display the current hostname.
6 Create a file named postfix.seed in the /tmp/ directory.
7 Move postfix.seed to /var/cache/debconf/ directory.
8 Display the contents of /var/cache/debconf/postfix.seed.
9 Preconfigure Postfix with the contents of /var/cache/debconf/postfix.seed.
10 Install Postfix.

comment
echo "The script is live!"
sleep 1
echo "Creating the Springboard program directory in the /etc directory"
echo ""
echo "---------------------------------------------------------"
echo "Here is the etc directory before the change:"
echo "---------------------------------------------------------"
echo ""
sudo ls -n /etc
sudo mkdir /etc/springboard
# Give ownership of springboard to my regular user
userID=$(id -u)
sudo chown -R $userID:$userID /etc/springboard
echo "---------------------------------------------------------"
echo ""
echo "Here is the etc directory after the change:"
echo "---------------------------------------------------------"
echo ""
sudo ls -n /etc
echo "---------------------------------------------------------"
echo ""
read -p "Please enter the domain name to use for this mailserver, Don't add the 'www., mail. or smtp.' just the domain:   " mailDomain
read -p "We are going to create a new non sudo user. Please enter a name for your new virtual inbound email address:   " regMailUser
mkdir /etc/springboard/vArs
touch /etc/springboard/vArs/mailDomain.txt
echo "$mailDomain" >> /etc/springboard/vArs/mailDomain.txt
touch /etc/springboard/vArs/regMailUser.txt
echo "$regMailUser" >> /etc/springboard/vArs/regMailUser.txt
sleep 1
echo "verifying if the variables were stored correctly..."
read -p "There is an untested if statemend here, Press enter to continue" xVar
if [ "$(cat /etc/springboard/vArs/mailDomain.txt)" = "$mailDomain" ] && [ "$(cat /etc/springboard/vArs/regMailUser.txt)" = "$regMailUser" ]
then
  echo "Great, the variables were stored correctly"
else
  echo "There is a problem with a mismatch between the contents of this programs text files and the variables.."
  read -p "would you like to continue?" xVar
fi
sleep 1
echo "if statement is passed"
echo "Adding new user $regMailUser"
read -p "Press enter to continue" xVar
sleep 1
sudo adduser $regMailUser
sleep 1
echo "Next we will set up the server name and IP so that the Mail DNS is in order..."
sudo hostname mail.$mailDomain
hostName=$(hostname)
echo "The Hostname for this server is set to $hostName"
# Assign IP to variable:
myIPv4=$(ip addr show | awk '{if (match($2,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)) {print $2}}' | head -2 | tail -1)
cat >/tmp/ipSort3r.txt <<EOF
$myIPv4
EOF
myIP=$(awk -F/ '{print $1}' /tmp/ipSort3r.txt) 
echo "The IP address for this server is: $myIP"
read -p "Press enter to remove the scrap tmp file we just made" xVar
sudo rm -r /tmp/ipSort3r.txt
echo "Add Host data to the end of hosts file:"
sudo echo "$myIP $hostName" >> /etc/hosts    
echo "setting up Pre-Seeding Parameters for automatic postfix installation..."
sleep 1
echo "before seed file in /tmp"
ls -a -1 /tmp/
sleep 1
touch /tmp/postfix.seed
echo "After seed file in /tmp"
ls -a -1 /tmp/
sleep 2
echo "postfix postfix/main_mailer_type string 'Internet Site'" >> /tmp/postfix.seed
echo "postfix postfix/mailname string $mailDomain" >> /tmp/postfix.seed
echo "/var/cache/debconf/ before mv"
ls -a -1 /var/cache/debconf/
sleep 2
sudo mv /tmp/postfix.seed /var/cache/debconf/
echo "/var/cache/debconf/ After file mv"
sleep 2
echo "verify contents"
cat /var/cache/debconf/postfix.seed
sleep 2
echo "Install & Preconfigure Postfix"
sudo debconf-set-selections /var/cache/debconf/postfix.seed
sudo apt install postfix -y
read -p "Press enter to continue" xVar
# If I wanted to split this into another script add this part so the variables are imported:
# mailDomain=$(cat /etc/springboard/vArs/mailDomain.txt)
# regMailUser=$(cat /etc/springboard/vArs/regMailUser.txt)
echo "Configuring Postfix..."
read -p "Press enter to continue" xVar
sudo postconf -e 'home_mailbox = Maildir/'
sudo postconf -e "mydomain = mail.$mailDomain"
# forgot to add cerbot install -may need to try preseeding this?
# sudo apt install certbot -y
echo "creating standalone certificate for the email"
read -p "Make sure you have your DNS ready then press enter to continue" xVar
sudo certbot certonly --standalone -d mail.$mailDomain
sudo postconf -e "smtpd_tls_cert_file = /etc/letsencrypt/live/mail.$mailDomain/fullchain.pem"
sudo postconf -e "smtpd_tls_key_file = /etc/letsencrypt/live/mail.$mailDomain/privkey.pem"
echo "installing Dovecot"
read -p "Press enter to continue" xVar
sudo apt install dovecot-common dovecot-imapd dovecot-pop3d -y 
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
sudo postconf -e 'virtual_alias_domains = $mydomain'
sudo postconf -e 'virtual_alias_maps = hash:/etc/postfix/virtual'
touch /tmp/virtual
echo "postmaster@$mailDomain root" >> /tmp/virtual
echo "root@$mailDomain root" >> /tmp/virtual
echo "info@$mailDomain info" >> /tmp/virtual
# Ownership \/ may ned to be explicitly set to root
sudo cp /tmp/virtual /etc/postfix/ # <-delete tmp file later
sudo postmap /etc/postfix/virtual
sudo systemctl restart postfix
#Added dovecot install to the top to this would run, also added certbot
sudo maildirmake.dovecot /etc/skel/Maildir
sudo maildirmake.dovecot /etc/skel/Maildir/.Drafts
sudo maildirmake.dovecot /etc/skel/Maildir/.Sent
sudo maildirmake.dovecot /etc/skel/Maildir/.Trash
sudo maildirmake.dovecot /etc/skel/Maildir/.Templates
sudo cp -r /etc/skel/Maildir /home/$regMailUser/
# Add a variable that determines the explicit id number for this other user NOT the current user.
uid=$(id -u "$regMailUser")
#sudo chown -R 1000:1000 /home/repomand/Maildir
sudo chown -R $uid:$uid /home/$regMailUser/Maildir
sudo chmod -R 700 /home/$regMailUser/Maildir
# sudo chmod -R 700 /home/repomand/Maildir
sudo adduser $regMailUser mail
echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
sleep 1
echo "Phase 1 Postfix configuration is complete"
sleep 1
echo "Starting Dovecot Installation..."
sleep 1
echo "Press Enter to continue..."
echo "Editing /etc/dovecot/conf.d/10-auth.conf..."
sleep 1
echo "Disable the plaintext authentication & enable the login authentication mechanism"
echo ""
sleep 0.5
echo "disable_plaintext_auth = yes"
echo "..."
echo "auth_mechanisms = plain login"
sleep 1
# The following command adds the line "disable_plaintext_auth = yes" to the file "/etc/dovecot/conf.d/10-auth.conf" 
# right after the line that starts with "#auth_allow_cleartext".
sudo sed -i "/#auth_allow_cleartext/a disable_plaintext_auth = yes/" /etc/dovecot/conf.d/10-auth.conf
# comment out this line
sudo sed -i "s/auth_mechanisms = plain/#auth_mechanisms = plain/" /etc/dovecot/conf.d/10-auth.conf
# Add this line right below it
sudo sed -i "/#auth_mechanisms = plain/a auth_mechanisms = plain login" /etc/dovecot/conf.d/10-auth.conf
sleep 1
echo ""
echo "Instruct the mail directory to use the same format as Postfix."
echo "Editing /etc/dovecot/conf.d/10-mail.conf..."
echo ""
sudo sed -i "s/#mail_location = /mail_location = maildir:~\/Maildir/" /etc/dovecot/conf.d/10-mail.conf
sleep 1
echo ""
echo "Configure the IMAP and POP3 protocols for email clients in the master.conf file "
echo ""
sudo sed -i "s/#port = 143/port = 143/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "s/#port = 110/port = 110/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "s/#unix_listener \/var\/spool\/postfix\/private\/auth {/unix_listener \/var\/spool\/postfix\/private\/auth {/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/unix_listener \/var\/spool\/postfix\/private\/auth {/a mode = 0660 #i7/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/mode = 0660 #i7/a group = postfix #i7/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/group = postfix #i7/a user = postfix #i7/" /etc/dovecot/conf.d/10-master.conf
sudo sed -i "/user = postfix #i7/a }" /etc/dovecot/conf.d/10-master.conf
sleep 1
echo ""
echo "Configure  default to the standard ports, 143 for IMAP and 110 for POP3. With STARTTLS required for every connection"
echo ""
echo "sudo nano /etc/dovecot/conf.d/10-ssl.conf"
echo ""
sleep 1
sudo sed -i "s/ssl = yes/ssl = required/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl_cert = <\/etc\/dovecot\/private\/dovecot.pem/ssl_cert = <\/etc\/letsencrypt\/live\/mail.$mailDomain\/fullchain.pem/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl_key = <\/etc\/dovecot\/private\/dovecot.key/ssl_key = <\/etc\/letsencrypt\/live\/mail.$mailDomain\/privkey.pem/" /etc/dovecot/conf.d/10-ssl.conf
sleep 1
echo ""
echo "Check the Dovecot configuration"
echo ""
sleep 1
sudo dovecot -n
sleep 1
echo ""
echo "Restart dovecot"
echo ""
sudo systemctl restart dovecot
sleep 1
echo ""
echo "Install mailutils"
echo ""
sudo apt install mailutils -y 
sleep 1
echo ""
echo "Additional security options"
echo ""
echo "Skipping for now..."
echo ""
echo "Open port 25 to allow smtp"
sudo ufw allow 25
sudo ufw allow 143
sudo ufw allow 110
sudo ufw status
sleep 1
echo "Everything should be set up, to test the mailserver"
echo "type the command "mail someone@email.com" to send a test email hit control+d to send it."
read -p "Press enter to exit the script" xVar
read -p "Press enter to continue" xVar