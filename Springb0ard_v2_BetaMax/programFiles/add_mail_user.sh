#!/bin/bash
#Created October 11th 2025
#sudo chmod +x add_mail_user.sh
#sudo ./add_mail_user.sh



# CONFIGURATION
#mailDomain="qmail.com"
#sudoUser="george"
sudoUser=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/sudoUser.txt)
mailDomain=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/mailDomain.txt)

# Ensure script is run as root
#if [[ $EUID -ne 0 ]]; then
#    echo "Run this script as root or with sudo."
#    exit 1
#fi

#read -p "Please enter the domain name ie:example.com: " mailDomain
#read -p "Please enter the sudo user name: " sudoUser
read -p "Please create a new username for your new virtual inbound email address: " regMailUser

# Check if user already exists
if id "$regMailUser" &>/dev/null; then
    echo "User $regMailUser already exists. Exiting."
    exit 1
fi

echo "Adding new system user: $regMailUser"
#adduser --disabled-password --gecos "" "$regMailUser"
adduser "$regMailUser"

echo "Creating Maildir for $regMailUser"
maildirmake.dovecot /etc/skel/Maildir
maildirmake.dovecot /etc/skel/Maildir/.Drafts
maildirmake.dovecot /etc/skel/Maildir/.Sent
maildirmake.dovecot /etc/skel/Maildir/.Trash
maildirmake.dovecot /etc/skel/Maildir/.Templates

cp -r /etc/skel/Maildir /home/$regMailUser/
chown -R "$regMailUser:$regMailUser" /home/$regMailUser/Maildir
chmod -R 700 /home/$regMailUser/Maildir

# Add user to mail group
adduser "$regMailUser" mail

# Export MAIL variable for system-wide login shells
echo 'export MAIL=~/Maildir' >> /etc/profile.d/mail.sh
chmod +x /etc/profile.d/mail.sh

# Set up Postfix virtual alias map
virtual_file="/etc/postfix/virtual"
touch "$virtual_file"
echo "$regMailUser@$mailDomain $regMailUser" >> "$virtual_file"
postmap "$virtual_file"

# Ensure Postfix is configured to use virtual_alias_maps
postconf -e "virtual_alias_maps = hash:/etc/postfix/virtual"

# Optional: set banner and smtps if not already done
postconf -e "smtpd_banner = \$myhostname ESMTP \$mail_name"

# (Re)start mail services
systemctl restart postfix
systemctl restart dovecot

echo "✅ Email user $regMailUser@$mailDomain successfully added."
