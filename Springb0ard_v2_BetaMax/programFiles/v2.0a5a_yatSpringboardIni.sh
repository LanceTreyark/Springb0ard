#!/bin/bash
# nano v2.0a5a_yatSpringboardIni.sh
# sudo chmod +x v2.0a5a_yatSpringboardIni.sh
# ./v2.0a5a_yatSpringboardIni.sh

# Installs Springboard Tools as options on an existing server
# these are the "yat" scripts they assume nothing other than the stated assumtions that are echoed at the top with a "press enter to proceed"

# Test if git is installed
# Test if postfix is installed
# Test if Dovecot it installed 

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

if [ $((gitWhichTest + gitDpkgTest)) -eq 0 ]; then
  echo "installing git..."
fi

if [ $((postfixWhichTest + postfixDpkgTest + postfixSystemctlTest)) -eq 0 ]; then
  echo "installing Postfix..."
fi

if [ $((dovecotWhichTest + dovecotDpkgTest + dovecotSystemctlTest)) -eq 0 ]; then
  echo "installing Dovecot..."
fi

