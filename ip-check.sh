#!/bin/bash

echo "Pulling repo from GitHub"
git pull origin kikpeni

echo "What's the IP ?"
read IP

if grep -Fxq "$IP" ./bambenek_*
then
	    echo "IP Exist"
    else
	        echo "IP not found, Exiting Now ...."
		exit
fi

git add .
git commit -m "Pushing repo back to GitHub"

echo "Pushing repo back to GitHub"
git push origin kikpeni
