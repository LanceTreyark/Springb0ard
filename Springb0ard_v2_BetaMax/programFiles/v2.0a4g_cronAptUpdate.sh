#!/bin/bash
# nano v2.0a4g_cronAptUpdate.sh
# sudo chmod +x v2.0a4g_cronAptUpdate.sh
# ./v2.0a4g_cronAptUpdate.sh
# It is assumed that this script is called to action by a crontab entry.
# Update process for cron:

LOCKFILE=/tmp/system_update.lock

if [ -e $LOCKFILE ]
then
    echo "System update already running. Exiting."
    exit 1
fi

# Create lock file
touch $LOCKFILE

# Run system update Script
  
todaysDate=$(date +%m%d%y)
timeNow=$(date +%I%M%p)
echo "Today is $todaysDate, the time is $timeNow"
echo "Running apt-update & upgrade..."
sudo apt update
sudo apt upgrade -y
echo "$(date) system update ran successfully"
echo "$(date) system update ran successfully" >> /etc/springb0ard/springb0ardUpdate.log
# Remove lock file
rm $LOCKFILE
