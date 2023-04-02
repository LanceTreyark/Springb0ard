#!/bin/bash
# Quick SCP - uses the hard variables written by v2.0a4b_Scp3r.sh to run faster only asks one question
#
# nano v2.0a4c_qscp.sh
# sudo chmod +x v2.0a4c_qscp.sh
# ./v2.0a4c_qscp.sh

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
exportAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
echo "Scp3r is live"
todaysDate=$(date +%m%d%y)
timeNow=$(date +%I%M%p)
zfilename="scp3r${todaysDate}${timeNow}.tar.gz"
echo "todaysDate $todaysDate"
echo "timeNow $timeNow"
echo "zFile name: $zfilename"
filePath=$(pwd)
echo ""
echo "Here is a list of your current directory:"
echo "-----------------------------------------------------------------------------"
ls -a -1
echo "-----------------------------------------------------------------------------"
read -p "enter the name of the file to be exported:   " fileName
echo "file to be exported is at the end of this path $filePath/$fileName"
echo "file to be exported to the end of this path $scpExportPath$zfilename"
echo "The export address will be: $exportAddr"
echo "Export file name will be: $zfilename"
cd $filePath
echo "Compressing file $fileName into $zfilename"
tar -zcvf $zfilename $fileName
echo "$zfilename"
echo "Sending to remote server via scp"
scp $zfilename $exportAddr:$scpExportPath$zfilename
echo "$zfilename will now be removed"
read -p "Press enter to proceed, or ctrl+c abort" x
rm $zfilename
echo "The script has concluded"
echo "Bye"