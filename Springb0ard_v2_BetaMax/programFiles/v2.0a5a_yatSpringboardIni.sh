#!/bin/bash
# nano v2.0a5a_yatSpringboardIni.sh
# sudo chmod +x v2.0a5a_yatSpringboardIni.sh
# ./v2.0a5a_yatSpringboardIni.sh

# Installs Springboard Tools as options on an existing server
# these are the "yat" scripts they assume nothing other than the stated assumtions that are echoed at the top with a "press enter to proceed"

# Test if git is installed
# Test if postfix is installed
# Test if Dovecot it installed 


# Check if Postfix is installed using 'which' command
if which postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'which' command)."
  echo "1" > /tmp/vArs/postfixWhichTest.txt
else
  echo "Postfix is not installed (checked using 'which' command)."
  echo "0" > /tmp/vArs/postfixWhichTest.txt  
fi

# Check if Postfix is installed using 'dpkg' command
if dpkg -s postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'dpkg' command)."
  echo "1" > /tmp/vArs/postfixDpkgTest.txt
else
  echo "Postfix is not installed (checked using 'dpkg' command)."
  echo "0" > /tmp/vArs/postfixDpkgTest.txt  
fi

# Check if Dovecot is installed using 'which' command
if which dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'which' command)."
  echo "1" > /tmp/vArs/dovecotWhichTest.txt  
else
  echo "Dovecot is not installed (checked using 'which' command)."
  echo "0" > /tmp/vArs/dovecotWhichTest.txt   
fi

# Check if Dovecot is installed using 'dpkg' command
if dpkg -s dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'dpkg' command)."
  echo "1" > /tmp/vArs/dovecotDpkgTest.txt 
else
  echo "Dovecot is not installed (checked using 'dpkg' command)."
  echo "0" > /tmp/vArs/dovecotDpkgTest.txt
fi

# Check if Git is installed using 'which' command
if which git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'which' command)."
  echo "1" > /tmp/vArs/gitWhichTest.txt
else
  echo "Git is not installed (checked using 'which' command)."
  echo "0" > /tmp/vArs/gitWhichTest.txt
fi

# Check if Git is installed using 'dpkg' command
if dpkg -s git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'dpkg' command)."
  echo "1" > /tmp/vArs/gitDpkgTest.txt
else
  echo "Git is not installed (checked using 'dpkg' command)."
  echo "0" > /tmp/vArs/gitDpkgTest.txt
fi

postfixWhichTest=$(cat /tmp/vArs/postfixWhichTest.txt)
postfixDpkgTest=$(cat /tmp/vArs/postfixDpkgTest.txt)
dovecotWhichTest=$(cat /tmp/vArs/dovecotWhichTest.txt)
dovecotDpkgTest=$(cat /tmp/vArs/dovecotDpkgTest.txt)
gitWhichTest=$(cat /tmp/vArs/gitWhichTest.txt)
gitDpkgTest=$(cat /tmp/vArs/gitDpkgTest.txt)
echo "postfixWhichTest=$postfixWhichTest"
echo "postfixDpkgTest=$postfixDpkgTest"
echo "dovecotWhichTest=$dovecotWhichTest"
echo "dovecotDpkgTest=$dovecotDpkgTest"
echo "gitDpkgTest=$gitWhichTest"
echo "gitDpkgTest=$gitDpkgTest"


if [ $((gitWhichTest + gitDpkgTest)) -eq 0 ]; then
  echo "installing git..."
fi

if [ $((postfixWhichTest + postfixDpkgTest)) -eq 0 ]; then
  echo "installing Postfix..."
fi

if [ $((dovecotWhichTest + dovecotDpkgTest)) -eq 0 ]; then
  echo "installing Dovecot..."
fi

<<comment
if [ $((gitWhichTest + gitDpkgTest)) -eq 1 ] || [ $((gitWhichTest + gitDpkgTest)) -eq 2 ]; then
  echo "installing git..."
fi

if [ $((postfixWhichTest + postfixDpkgTest)) -eq 1 ] || [ $((postfixWhichTest + postfixDpkgTest)) -eq 2 ]; then
  echo "installing Postfix..."
fi

if [ $((dovecotWhichTest + dovecotDpkgTest)) -eq 1 ] || [ $((dovecotWhichTest + dovecotDpkgTest)) -eq 2 ]; then
  echo "installing Dovecot..."
fi
comment