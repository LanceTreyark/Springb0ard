#!/bin/bash
# nano 0a3aa_Postfix.DKIM.sh
# sudo chmod +x 0a3aa_Postfix.DKIM.sh
# ./0a3aa_Postfix.DKIM.sh
#!!!!!!!!!!!!!!!!!!!!   KEEP IN MIND THIS IS A PUBLIC REPO  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<<comment
* TITLE: 0a3aa_Postfix.DKIM.sh
* AUTHOR: Lance Pierson
* DATE: 3/11/2023

PURPOSE:

This is an addendum to the automatic SMTP email server installer 
This code installs DKIM keys and provides the user with all of the required email DNS records
comment

#call vArs
mailDomain=$(cat /etc/springboard/vArs/mailDomain.txt)
regMailUser=$(cat /etc/springboard/vArs/regMailUser.txt)
sudoUser=$(cat /etc/springboard/vArs/sudoUser.txt)
echo "The script is live!"
sleep 1

#sudo apt install opendkim opendkim-tools -y
#sudo sed -i "/#Mode/a Mode                   sv" /etc/opendkim.conf
#sudo sed -i "/#Domain/a Domain                 $mailDomain" /etc/opendkim.conf
#sudo sed -i "/#Selector/a Selector               2020" /etc/opendkim.conf
#sudo sed -i "/#KeyFile/a KeyFile                /etc/dkimkeys/example.private" /etc/opendkim.conf
cd /home/$sudoUser

# \/ This
#sudo /usr/sbin/opendkim-genkey -b 2048 -d $mailDomain -s default


# \/ This
sudoUserID=$(id -u $sudoUser)

# \/ This
sudo cp default.txt defaultXyz.txt

### \/ This makes sure ownership is readable w/o sudo
sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/defaultXyz.txt

#----------------------------------------------------------
# THIS CODE IS NOT GOOD YET
#----------------------------------------------------------

# # \/ This Reads the contents of defaultx.txt into a variable
contents=$(cat defaultx.txt)

# # \/ This Replacse line breaks with a space
contents=${contents//$'\n'/' '}

# # \/ This Removes extra spaces and tabs
contents=$(echo $contents | tr -s '[:blank:]' ' ')

# # \/ This Inserts a newline character every 64 characters
contents=$(echo $contents | fold -w 64 -s | sed 's/^/  "/;s/$/"/')      

# # \/ This Adds the DNS record prefix
#contents="default._domainkey  IN  TXT   (\n$contents\n)"

# # \/ This Outputs the reformatted contents
echo -e $contents

#--------------------
# ./DKIM.sh



# # \/ This reads input file into variable
input=$(cat new_mod.txt)

# # \/ This removes newlines and replace with space
input=${input//$'\n'/ }

# # \/ This inserts quotes at beginning and end of input
input="\"$input\""

# # \/ This inserts newlines every 255 characters
output=$(echo "$input" | fold -w 64 -s | sed 's/^/"/; s/$/"/')

# # \/ This writes output to file
echo "$output" > new_mod2.txt

# # \/ This prints the contents of the new_mod2.txt file
cat new_mod2.txt

#___________________________________________________

# # # This command 
sudo sed -i 's/\(\w\{9\}\)\s\{2\}/\1/' mod.txt
sudo sed -i 's/\(\w\{9\}\)\s\{2\}/\1/' new_mod.txt

# \/\/ This command takes the contents of the file mod.txt, 
#      removes all newline characters from it, and then writes 
#      the resulting output to a new file named new_mod.txt.
cat mod.txt | tr -d '\n' > new_mod.txt

# # # This command 
# gold
sed 's/\s//g' mod.txt > new_mod.txt

# # # This command 


# # # This command 


# # # This command 


# # # This command 


# # # This command 


# # # This command 

<<comment
#----------------------------------------------------------


# # \/ This Reads the contents of the file into a variable
# dkim=$(cat defaultx.txt)

# # \/ This Removes any newlines from the variable
# dkim=${dkim//$'\n'/}

# # \/ This Inserts a newline character after every 255 characters
# dkim=$(echo $dkim | sed 's/.\{255\}/&\n/g')

# # \/ This Adds double quotes around the DKIM record
# dkim='"'$dkim'"'

# # \/ This Prints the reformatted DKIM record
# echo "default._domainkey  IN  TXT   ($dkim)"

#----------------------------------------------------------
comment
###

#ADD A VAR
# echo "#variable" >> /etc/springboard/vArs/variable.txt
#
#CALL A VAR
# #variable=$(cat /etc/springboard/vArs/variable.txt)

###
sleep 1
echo "the script has concluded."
echo "bye"