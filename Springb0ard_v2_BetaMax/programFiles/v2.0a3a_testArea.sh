#!/bin/bash
# This is for running tests 
# you can execute or edit this script with these alias commands:
# sb-test         --Run test script
# sb-etest        --Edit test script

sudoUser=$(who am i | awk '{print $1}')
echo "sudoUser=$sudoUser"


if which postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'which' command)."
  postfixWhichTest="1"
else
  echo "Postfix is not installed (checked using 'which' command)."
  postfixWhichTest="0"
fi

if dpkg -s postfix >/dev/null 2>&1; then
  echo "Postfix is installed (checked using 'dpkg' command)."
  postfixDpkgTest="1"
else
  echo "Postfix is not installed (checked using 'dpkg' command)."
  postfixDpkgTest="0" 
fi

if systemctl is-active --quiet postfix; then
  echo "Postfix is installed and active (checked using systemctl command)."
  postfixSystemctlTest="1"
else
  echo "Postfix is not installed or inactive (checked using systemctl command)."
  postfixSystemctlTest="0"
fi

if which dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'which' command)."
  dovecotWhichTest="1"
else
  echo "Dovecot is not installed (checked using 'which' command)."
  dovecotWhichTest="0"

fi

if dpkg -s dovecot >/dev/null 2>&1; then
  echo "Dovecot is installed (checked using 'dpkg' command)."
  dovecotDpkgTest="1"
else
  echo "Dovecot is not installed (checked using 'dpkg' command)."
  dovecotDpkgTest="0"
fi

if systemctl is-active --quiet dovecot; then
  echo "Dovecot is installed and active (checked using systemctl command)."
  dovecotSystemctlTest="1"
else
  echo "Dovecot is not installed or inactive (checked using systemctl command)."
  dovecotSystemctlTest="0"
fi

if which git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'which' command)."
  gitWhichTest="1"
else
  echo "Git is not installed (checked using 'which' command)."
  gitWhichTest="0"
fi

if dpkg -s git >/dev/null 2>&1; then
  echo "Git is installed (checked using 'dpkg' command)."
  gitDpkgTest="1"
else
  echo "Git is not installed (checked using 'dpkg' command)."
  gitDpkgTest="0"
fi

echo "postfixWhichTest=$postfixWhichTest"
echo "postfixDpkgTest=$postfixDpkgTest"
echo "postfixSystemctlTest=$postfixSystemctlTest"
echo "dovecotWhichTest=$dovecotWhichTest"
echo "dovecotDpkgTest=$dovecotDpkgTest"
echo "dovecotSystemctlTest=$dovecotSystemctlTest"
echo "gitWhichTest=$gitWhichTest"
echo "gitDpkgTest=$gitDpkgTest"

if [ $((postfixWhichTest + postfixDpkgTest + postfixSystemctlTest)) -ge 1 ]; then
  echo "Postfix is currently installed on this system"
  #echo "Removing previous Postfix installation ..."
  #sudo apt-get remove --purge postfix
  #sudo apt-get autoremove --purge
  #sudo apt-get clean
fi

if [ $((dovecotWhichTest + dovecotDpkgTest + dovecotSystemctlTest)) -ge 1 ]; then
  echo "Dovecot is currently installed on this system"
  #echo "Removing previous Dovecot installation..."
  #sudo apt-get remove --purge dovecot
  #sudo apt-get autoremove --purge
  #sudo apt-get clean
fi