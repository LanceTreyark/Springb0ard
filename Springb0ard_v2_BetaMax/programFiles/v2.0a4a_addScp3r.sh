#!/bin/bash
# nano v2.0a4a_addScp3r.sh
# sudo chmod +x v2.0a4a_addScp3r.sh
# ./v2.0a4a_addScp3r.sh


#Call your vArs!
yourDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
mailDomain=$(cat /etc/springb0ard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springb0ard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springb0ard/vArs/sudoUser.txt)
sudoUserID=$(cat /etc/springb0ard/vArs/sudoUserID.txt)
myIP=$(cat /etc/springb0ard/vArs/myIP.txt)
webAdminEmail=$(cat /etc/springb0ard/vArs/webAdminEmail.txt)
webDomainName=$(cat /etc/springb0ard/vArs/mailDomain.txt)


echo  "Checking for server side ssh keys to add to your SCP destinations authorized_users file:"
#####
# check the server for an ssh key, if one does not exist offer to make one
# ask user if the key has been added to your SCP destinations authorized users file.
#-----------------------------------------------------------------------------
if [ -f /home/$sudoUser/.ssh/id_rsa.pub ]; then
    cat /home/$sudoUser/.ssh/id_rsa.pub
    read -p "Have you added this key to to your SCP destinations authorized_users file? (Y/N) " response
    if [ "$response" = "n" ]; then
        echo "Please add this key to your SCP destinations authorized_users file."
    fi
else
    read -p "It appears that an ssh key has not been generated. Would you like to create one? (Y/N) " response
    if [ "$response" = "y" ]; then
        ssh-keygen
        echo ""
        cat /home/$sudoUser/.ssh/id_rsa.pub
        echo ""
        echo "Please add this key to your Github settings."
        echo ""
    else
        echo "If you don't add the ssh-key the SCP communication will fail. Are you shure you want to skip this?"
        read -p "Enter (Y/N): " choice
        if [ "$choice" = "n" ]; then
            ssh-keygen
            cat /home/$sudoUser/.ssh/id_rsa.pub
            echo "Please add this key your SCP destinations authorized_users file."
        fi
    fi
fi
#####

# add the default vAr file so we dont get an error notification the first time the script is run.
touch /etc/springb0ard/vArs/defaultScpAddr.txt



## Add program file:
curl -o /tmp/v2.0a4b_Scp3r.sh "https://raw.githubusercontent.com/LanceTreyark/Springb0ard/main/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh"
#make exe
sudo chmod +x /tmp/v2.0a4b_Scp3r.sh
#mv to dir
sudo mv /tmp/v2.0a4b_Scp3r.sh /etc/springb0ard/programFiles/

#add alias command 'scp3r'
echo 'alias scp3r="sh /etc/springb0ard/programFiles/v2.0a4b_Scp3r.sh"' >> /home/$sudoUser/.bash_aliases