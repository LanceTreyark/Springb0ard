#!/bin/bash
# nano v2.0a4d_cronTabAutomation
# sudo chmod +x v2.0a4d_cronTabAutomation
# ./v2.0a4d_cronTabAutomation
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
# Purpose stupid simple adding of crontab commands

#add 2 sudo crontab rules

# 1 Redirect the standard error stream of crontab -l command to /dev/null
# 2 Add the first crontab entry
# 3 Add the second crontab entry 
# 4 Verify the crontab entries by listing them using crontab -l command.


# Add the first crontab entry
# cd to springb0ard run git pull then run the manager to make sure all scripts are executable and aliased

(crontab -l 2>/dev/null; echo "*/30 * * * * cd /etc/postfix && sudo git add . && sudo ./Q_Com_v0.0.sh && sudo git push -u origin main && cd -") | crontab -

# Add the second crontab entry
(crontab -l 2>/dev/null; echo "*/30 * * * * cd /etc/dovecot && sudo git add . && sudo ./Q_Com_v0.0.sh && sudo git push -u origin main && cd -") | crontab -

# Verify the crontab entries have been added
crontab -l

<<comment
#this runs it every 3 days at midnight:
#!/bin/bash 

# Add the first crontab entry
(crontab -l 2>/dev/null; echo "0 0 */3 * * cd /etc/postfix && sudo git add . && sudo ./Q_Com_v0.0.sh && sudo git push -u origin main && cd -") | crontab -

# Add the second crontab entry
(crontab -l 2>/dev/null; echo "0 0 */3 * * cd /etc/dovecot && sudo git add . && sudo ./Q_Com_v0.0.sh && sudo git push -u origin main && cd -") | crontab -

# Verify the crontab entries have been added
crontab -l
comment



