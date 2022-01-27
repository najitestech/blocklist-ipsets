#!/bin/bash

git config --global user.email "najitestech@gmail.com"
git config --global user.name "Kelvin Ikpeni"

echo "Pulling repo from GitHub"
git pull origin kikpeni

echo "What's the IP ?"
read IP

if grep -Fxq "$IP" ./bambenek_*
then
	    echo "IP Exist in ./bambenek_*"
    else
	        echo "IP not found, Exiting Now ...."
		echo "Adding new IP '$IP' to the list"
		echo "$IP" >> new-iplist.txt
fi

git add .
git commit -m "Pushing repo back to GitHub"

echo "Pushing repo back to GitHub"
git push origin kikpeni
