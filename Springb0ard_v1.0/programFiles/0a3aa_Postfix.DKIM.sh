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

# Make sure you are in the proper directory
cd /home/$sudoUser

# \/ This Creates our DKIM Keys
#sudo /usr/sbin/opendkim-genkey -b 2048 -d $mailDomain -s default


# \/ This creates a variable to hold the current users id # ie 1001
sudoUserID=$(id -u $sudoUser)


#----------------------------------------------------------
# Begin with DNS Syntaxing
#----------------------------------------------------------
#Here is the plan:

# PHASE 1) we copy the actual key file to a working file & make it writable

# \/ This copies the keys to a working file that we can modify or 
#    delete without messing with the system
#sudo cp default.txt defaultX1.txt

### \/ This makes sure our working file is writable for the corrent
#       user because the original file is owned by root.
#sudo chown -R $sudoUserID:$sudoUserID /home/$sudoUser/defaultX1.txt

# PHASE 2) Pluck out the key from the header and footer
awk '/default\._domainkey.*\(/ {flag=1; next} /)/ {flag=0} flag && /p=/ {sub(/.*p=/, "p=", $0); sub(/".*/, "", $0); print $0; exit}' defaultX1.txt > DKIM_Top.txt
awk -F'"' '/default._domainkey/{getline; getline; print $2}' defaultX1.txt > DKIM_bottom.txt
# read input file into variable
DKIM_Top=$(cat DKIM_Top.txt)
DKIM_bottom=$(cat DKIM_bottom.txt)
# PHASE 4) Combine into a single string then reak up into 64 char lines and wrap in quotes
echo $DKIM_Top$DKIM_bottom > DKIM_Full.txt
cat DKIM_Full.txt
DKIM_Full=$(cat DKIM_Full.txt)
# insert new quoted lines every 64 characters 
linoel=$(echo "$DKIM_Full" | fold -w 64 -s | sed 's/^/"/; s/$/"/')
# write output to file
echo "$linoel" > DKIM_Segmented.txt


# PHASE 3) remove quotes, spaces and new lines

# \/\/ This command takes the contents of the file defaultX1.txt, 
#      removes all newline characters from it, and then writes 
#      the resulting output to a new file named defaultX2.txt.
#cat defaultX1.txt | tr -d '\n' > defaultX2.txt

# # # This command takes the data defaultX2.txt & replaces all
# occurrences of whitespace (spaces and tabs) with nothing.
# then saves the output in a new file named "defaultX3.txt".
#sed 's/\s//g' defaultX2.txt > defaultX3.txt

# PHASE 4) break up into 64 char lines and wrap in quotes

# read input file into variable
#input=$(cat defaultX3.txt)

# remove newlines and replace with space
#input=${input//$'\n'/ }

# # \/ This Removes extra spaces and tabs
#input=$(echo $input | tr -s '[:blank:]' ' ')


# insert new quoted lines every 64 characters 
#output=$(echo "$input" | fold -w 64 -s | sed 's/^/"/; s/$/"/')

# write output to file
#echo "$output" > defaultX4.txt


# PHASE 6) add DNS header
# # \/ This Reads the contents of defaultx.txt into a variable
#contents=$(cat defaultX4.txt)
    

# # \/ This Adds the DNS record prefix
#contents="default._domainkey  IN  TXT   (\n$contents\n)"

# # \/ This Outputs the reformatted contents
#echo $contents > defaultX5.txt

#cat defaultX5.txt
###
sleep 1
echo "the script has concluded."
echo "bye"