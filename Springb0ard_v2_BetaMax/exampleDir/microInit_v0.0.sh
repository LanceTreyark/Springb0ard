#!/bin/bash
#v.020623
read -p "What is the remote origin for this new repository?   " gitOrigin1
sudo git init
sudo git add .
sudo git commit -m "first commit"
sudo git branch -M main
sudo git remote add origin $gitOrigin1
sudo git push -u origin main