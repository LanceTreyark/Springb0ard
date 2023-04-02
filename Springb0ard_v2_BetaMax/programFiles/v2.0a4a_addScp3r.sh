#!/bin/bash
echo "Null" > /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt
echo "Null" > /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt
# nano v2.0a4a_addScp3r.sh
# sudo chmod +x v2.0a4a_addScp3r.sh
# ./v2.0a4a_addScp3r.sh
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
cd /etc/springb0ard/Springb0ard/ 
git pull
cd -
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh
sudo chmod +x /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh
while read -r line; do
  alias_name=$(echo "$line" | cut -d'"' -f2)
  if ! grep -q "$alias_name" /home/$sudoUser/.bash_aliases; then
    echo "$line" >> /home/$sudoUser/.bash_aliases
  fi
done <<EOF
alias scp3r="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4b_Scp3r.sh"
alias qscp="sh /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/programFiles/v2.0a4c_qscp.sh"
EOF

echo "the installer has concluded"