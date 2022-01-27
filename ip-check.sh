#!/bin/bash

file_name=new-iplist

git config --global user.email "najitestech@gmail.com"
git config --global user.name "Kelvin Ikpeni"

echo "Pulling repo from GitHub"
git pull origin kikpeni

echo "What's the IP ?"
read IP

if grep $IP * -lR
then
	echo "IP Exist in the above file (s)"
	    exit
    else
	        echo "IP not found"
		echo "Adding new IP '$IP' to the list '$file_name.txt'"
		echo "$IP" >> $file_name.txt
fi

git add .
git commit -m "Pushing repo back to GitHub"

echo "Pushing repo back to GitHub"
git push origin kikpeni

#Save a copy of new iplist file to S3 bucket
aws s3 cp $file_name.txt s3://iplist-test
