#!/bin/bash
<<comment
* TITLE: 0a2c_gitLocalAlias.sh
* AUTHOR: LP
* DATE: 2.8.23
* PURPOSE: I need the dude command upgraded to full Lebowski..when you set up
        a new repo it needs to automatically copy over the handling scripts
        This script will set up a local repository
comment
whereYat=$(pwd) 
cp /etc/Springb0ard_v1.0/exampleDir/microInit_i1.sh $whereYat/
cp /etc/Springb0ard_v1.0/exampleDir/Q_Com.sh $whereYat/
userID=$(id -u)
sudo chown -R $userID:$userID $whereYat/microInit_i1.sh
sudo chown -R $userID:$userID $whereYat/Q_Com.sh
./microInit_i1.sh