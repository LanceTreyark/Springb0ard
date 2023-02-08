#!/bin/bash
<<comment
* TITLE: 0a2d_gitRootAlias.sh
* AUTHOR: LP
* DATE: 2.8.23
* PURPOSE: I need the dude command upgraded to full Lebowski..when you set up
        a new repo it needs to automatically copy over the handling scripts
        This script will set up a root repository
comment
whereYat=$(pwd) 
cp /etc/Springb0ard_v1.0/exampleDir/microInit_v0.0.sh $whereYat/
cp /etc/Springb0ard_v1.0/exampleDir/Q_Com_v0.0.sh $whereYat/
#sudo chown -R 1000:1000 $whereYat/microInit_i1.sh
#sudo chown -R 1000:1000 $whereYat/Q_Com.sh
./microInit_v0.0.sh