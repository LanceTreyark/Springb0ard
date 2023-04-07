#!/bin/bash
# nano v2.0a5a_yatSpringboardIni.sh
# sudo chmod +x v2.0a5a_yatSpringboardIni.sh
# ./v2.0a5a_yatSpringboardIni.sh

# Installs Springboard Tools as options on an existing server
# these are the "yat" scripts they assume nothing other than the stated assumtions that are echoed at the top with a "press enter to proceed"

# Test if git is installed
# Test if postfix is installed
# Test if Dovecot it installed 

#!/bin/bash

# Check if Postfix is installed
mkdir -p /tmp/vArs
if dpkg -s postfix >/dev/null 2>&1; then
  echo "Postfix is installed."
  echo "1" > /tmp/vArs/postfixTest.txt
else
  echo "Postfix is not installed."
  echo "0" > /tmp/vArs/postfixTest.txt
fi

# Check if Dovecot is installed
if dpkg -s dovecot-core >/dev/null 2>&1; then
  echo "Dovecot is installed."
  echo "1" > /tmp/vArs/dovecotTest.txt
else
  echo "Dovecot is not installed."
  echo "0" > /tmp/vArs/dovecotTest.txt
fi

# Check if Git is installed
if which git >/dev/null 2>&1; then
  echo "Git is installed."
  echo "1" > /tmp/vArs/gitTest.txt
else
  echo "Git is not installed."
  echo "0" > /tmp/vArs/gitTest.txt
fi
postfixTest=$(cat /tmp/vArs/postfixTest.txt)
dovecotTest=$(cat /tmp/vArs/dovecotTest.txt)
gitTest=$(cat /tmp/vArs/gitTest.txt)
echo "postfixTest=$postfixTest"
echo "dovecotTest=$dovecotTest"
echo "gitTest=$gitTest"