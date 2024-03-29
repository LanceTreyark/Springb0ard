#!/bin/bash
# nano v2.0a4b_Scp3r.sh
# sudo chmod +x v2.0a4b_Scp3r.sh
# ./v2.0a4b_Scp3r.sh

# ini path \/ comment out or delete after first run.
#echo "/tmp/" > /etc/springb0ard/vArs/scpExportPath.txt
# ini path /\
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
echo "Scp3r is live"
echo "Your current path is:"
pwd
echo ""
todaysDate=$(date +%m%d%y)
timeNow=$(date +%I%M%p)
zfilename="scp3r${todaysDate}${timeNow}.tar.gz"
echo "todaysDate $todaysDate"
echo ""
echo "timeNow $timeNow"
echo ""
echo "zFile name: $zfilename"
sleep 2
echo ""
echo "(OPTIONAL) Add the path to the file you want to export ie: ~/exampleDir/ "
read -p "If nothing is entered the program will use your current path   " filePath
filePath=${filePath:-$(pwd)}
echo ""
echo "Here is a list of your current directory:"
echo "-----------------------------------------------------------------------------"
ls -a -1
echo "-----------------------------------------------------------------------------"
read -p "enter the name of the file to be exported:   " fileName
echo ""
echo "(OPTIONAL) Enter the export address ie:user@152.44.45.125"                                                                                                                                                                                                   
read -p "If nothing entered the default user is used '$defaultScpAddr':   " exportAddr 
read -p "would you like to add $exportAddr as your new default address? Y/N:" addNewDefault
if [ "$addNewDefault" = "y" ] || [ "$addNewDefault" = "Y" ]; then
  echo "writing $exportAddr to file"
  echo "$exportAddr" > /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt
  echo "here is the current value after writing"
  cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt
fi
exportAddr=${exportAddr:-$defaultScpAddr}
echo ""
echo "here is the data you provided:"
echo "file to be exported is at the end of following path:"
echo "$filePath$fileName"
echo ""
echo "The export address will be: $exportAddr"
echo ""
sleep 1
echo "Export file name will be: $zfilename"
sleep 1
echo " "
echo "Nav to dir"
cd $filePath
echo "Compressing file $fileName into $zfilename"
echo ""
sleep 1
tar -zcvf $zfilename $fileName
sleep 2
echo "$zfilename"
echo ""
#
echo "The default export path is $scpExportPath"
read -p "If you would like to use a different path add it here ie: 'C:/Users/me/Desktop/'   " newScpExportPath
read -p "would you like to add $newScpExportPath as your new default export path? Y/N:" addNewScpDefaultPath

if [ "$addNewScpDefaultPath" = "y" ] || [ "$addNewScpDefaultPath" = "Y" ]; then
  echo "Writing $newScpExportPath to file"
  echo "$newScpExportPath" > /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt
  echo "Here is the current value after writing:"
  cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt   
fi

scpExportPath=${scpExportPath:-$newScpExportPath}
# update entry
defaultScpAddr=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/defaultScpAddr.txt)
scpExportPath=$(cat /etc/springb0ard/Springb0ard/Springb0ard_v2_BetaMax/vArs/scpExportPath.txt)
echo "Sending to remote server via scp"
#scp $zfilename $exportAddr:C:/$zfilename
#scp $zfilename $exportAddr:/tmp/$zfilename
scp $zfilename $exportAddr:$scpExportPath$zfilename
echo "$zfilename will now be removed"
read -p "Press enter to proceed, or ctrl+c abort" x
rm $zfilename
echo "The script has concluded"
echo "Bye"