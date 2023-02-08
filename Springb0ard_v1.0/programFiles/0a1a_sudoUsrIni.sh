#!/bin/bash
<<comment
* TITLE:  0a1a_sudoUsrIni.sh
* AUTHOR: Lance Pierson
* EMAIL:  info@treyark.com
* DATE:   2/5/23
* EXECUTIVE SUMMARY: Master Controller
* UNIT TEST RESULT: SUCCESS 455am 2.8.23

sudo chmod +x 0a1a_Master.sh
sudo chmod +x 0a2a_test.sh
sudo chmod +x 0a2b_test.sh

comment

echo "Begin test script 1"
sleep 1
echo "Press Enter to continue..."
read -s -p ""
./0a2a_test.sh
sleep 1
echo "Begin test script 2"
sleep 1
echo "Press Enter to continue..."
read -s -p ""
./0a2b_test.sh
sleep 1
echo "Script Completed"
sleep 1
echo "Press Enter to exit..."
read -s -p ""