#!/bin/bash
# nano v2.0a4a_addScp3r.sh
# sudo chmod +x v2.0a4a_addScp3r.sh
# ./v2.0a4a_addScp3r.sh

echo  "Creating server side ssh keys to add to your authorized users file:"
ssh-keygen

# add the default vAr file so we dont get an error notification the first time the script is run.
touch /etc/springb0ard/vArs/defaultScpAddr.txt



## Add program file:
curl -o /tmp/v2.0a1a_springb0ardManager2.sh "url"
#make exe
sudo chmod +x /tmp/v2.0a1a_springb0ardManager2.sh
#mv to dir
sudo mv /tmp/v2.0a1a_springb0ardManager2.sh /etc/springb0ard/programFiles/

#add alias command 'scp3r'
echo 'alias newAlias="sh /etc/springb0ard/programFiles/v2.0a1a_springb0ardManager2.sh"' >> /home/$sudoUser/.bash_aliases