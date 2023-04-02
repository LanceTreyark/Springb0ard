#!/bin/bash
# nano v2.0a2a_installPostfix.sh
# sudo chmod +x v2.0a2a_installPostfix.sh
# ./v2.0a2a_installPostfix.sh
echo "The script is live!"
#Call your vArs!
yourDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)
defaultScpAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
scpExportPath=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt)
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
echo "defaultScpAddr=$defaultScpAddr"
echo "scpExportPath=$scpExportPath"
echo "-----------------------------"
echo "making sure we own the springb0ard directory..."
sudo chown -R $sudoUserID:$sudoUserID /etc/springb0ard
sleep 1
echo "Checking the springb0ard program directory in the /etc directory"
echo ""
echo "---------------------------------------------------------"
echo ""
ls /etc/springb0ard
echo "---------------------------------------------------------"
echo ""
echo "Here is the etc directory after the change:"
echo "---------------------------------------------------------"
echo ""
sudo ls /etc
echo "---------------------------------------------------------"
echo ""
sleep 1
echo "Opening required mail ports..."
sudo ufw allow 25
sudo ufw allow 143
sudo ufw allow 110
sudo ufw allow 554
sudo ufw allow "WWW Full"
sudo ufw allow 993
sudo ufw allow 995
sudo ufw allow 587
sudo ufw status
echo "Adding new user $regMailUser"
sleep 1
sudo adduser $regMailUser
sleep 1
echo "Next we will set up the server name and IP so that the Mail DNS is in order..."
sudo hostname mail.$mailDomain
hostName=$(hostname)
echo "The Hostname for this server is set to $hostName"
echo ""
sleep 1
echo "We are going to add the domain name to the hosts file"
sleep 1
echo "here is the file currently:"
sleep 1
echo "------------------------------------------------------"
sudo cat /etc/hosts
echo "------------------------------------------------------"
echo "Ammending to '127.0.0.1 localhost mail.$mailDomain'"
sudo sed -i "/127.0.0.1/a $myIP mail.$mailDomain" /etc/hosts
echo ""
sleep 1
echo "Here is the amended file:"
echo "------------------------------------------------------"
sudo cat /etc/hosts
echo "------------------------------------------------------"
echo ""
sleep 1
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
########################
# Postfix Installation #
########################
echo "Install & Preconfigure Postfix"
echo " in just a sec..."
sudo debconf-set-selections /var/cache/debconf/postfix.seed
sudo apt install postfix -y
echo "making a default copy of postfix"
sudo cp -r /etc/postfix /etc/postfixCopy
echo "Configuring Postfix..."
sudo postconf -e 'home_mailbox = Maildir/'
sudo postconf -e "mydomain = $mailDomain"
sudo apt install certbot -y
echo "creating standalone certificate for the email"
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
sudo certbot certonly --standalone -d mail.$mailDomain
sudo postconf -e "smtpd_tls_cert_file = /etc/letsencrypt/live/mail.$mailDomain/fullchain.pem"
sudo postconf -e "smtpd_tls_key_file = /etc/letsencrypt/live/mail.$mailDomain/privkey.pem"
echo "installing Dovecot"
sudo apt install dovecot-common dovecot-imapd dovecot-pop3d -y 
sudo cp -r /etc/dovecot /etc/dovecotCopy
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
uid=$(id -u "$regMailUser")
sudo chown -R $uid:$uid /home/$regMailUser/Maildir
sudo chmod -R 700 /home/$regMailUser/Maildir
sudo adduser $regMailUser mail
echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
sleep 1
echo "Phase 1 Postfix configuration is complete"
sleep 1
########################
# Dovecot Installation #
########################
echo "Starting Dovecot Installation..."
sleep 1
echo "Editing /etc/dovecot/conf.d/10-auth.conf..."
sleep 1
echo "Disable the plaintext authentication & enable the login authentication mechanism"
echo ""
sleep 0.5
echo "disable_plaintext_auth = yes"
echo "..."
echo "auth_mechanisms = plain login"
sleep 1
sudo sed -i "/#disable_plaintext_auth = yes/a disable_plaintext_auth = no" /etc/dovecot/conf.d/10-auth.conf
sudo sed -i "s/auth_mechanisms = plain/#auth_mechanisms = plain/" /etc/dovecot/conf.d/10-auth.conf
sudo sed -i "/#auth_mechanisms = plain/a auth_mechanisms = plain login" /etc/dovecot/conf.d/10-auth.conf
sleep 1
echo ""
echo "Instruct the mail directory to use the same format as Postfix."
echo "Editing /etc/dovecot/conf.d/10-mail.conf..."
echo ""
sleep 1
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
sleep 1
echo ""
echo "Configure  default to the standard ports, 143 for IMAP and 110 for POP3. With STARTTLS required for every connection"
echo ""
echo "sudo nano /etc/dovecot/conf.d/10-ssl.conf"
echo ""
sleep 1
sudo sed -i "s/#ssl_min_protocol = TLSv1/ssl_min_protocol = TLSv1/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl = yes/ssl = required/" /etc/dovecot/conf.d/10-ssl.conf
# or if thats not there do this
sudo sed -i "s/#ssl = required/ssl = required/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl_cert = <\/etc\/dovecot\/private\/dovecot.pem/ssl_cert = <\/etc\/letsencrypt\/live\/mail.$mailDomain\/fullchain.pem/" /etc/dovecot/conf.d/10-ssl.conf
sudo sed -i "s/ssl_key = <\/etc\/dovecot\/private\/dovecot.key/ssl_key = <\/etc\/letsencrypt\/live\/mail.$mailDomain\/privkey.pem/" /etc/dovecot/conf.d/10-ssl.conf
sleep 1
echo ""
sudo sed -i "s/mail_location = mbox:~\/mail:INBOX=\/var\/mail\/%u/mail_location = maildir:~\/Maildir/" /etc/dovecot/conf.d/10-mail.conf
echo "Check the Dovecot configuration"
echo ""
sleep 1
sudo dovecot -n
sleep 1
echo ""
echo "Restart dovecot"
echo ""
sudo systemctl restart dovecot
sudo systemctl restart postfix
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
sleep 1
sudo systemctl restart postfix
echo "Everything should be set up, to test the mailserver"
echo "Initiating webserver installer 0a1b"
sleep 2
echo "Next,"
echo "sh /etc/springb0ard/programFiles/v2.0a3a_basicWebServer.sh"
sh /etc/springb0ard/programFiles/v2.0a3a_basicWebServer.sh