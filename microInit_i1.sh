#!/bin/bash
#v.020523
read -p "What is the remote origin for this new repository?   " gitOrigin1
git init
git add .
git commit -m "First Commit"
git branch -M main
git remote add origin $gitOrigin1
git push -u origin main