#!/bin/bash
# v.020623
<<comment
Author: LP
Date: 2.6.23
PURPOSE: This is used by cron to automate git add, commit & push main
sudo or non sudo
comment
date_time="$(date +"%m.%d.%y %I:%M%p")"
echo " "
echo "* "
git commit -m "$date_time"
echo "*  *"
echo "*  *  *"
sleep 1
echo "Script i.020623 Complete"