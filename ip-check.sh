#!/bin/bash

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

file_name=new-iplist
s3_bucket=iplist-test

git config --global user.email "najitestech@gmail.com"
git config --global user.name "Kelvin Ikpeni"

#Git pull code from git remot branch
echo "Pulling repo from GitHub"
git pull origin kikpeni

#System prompt for IP
echo "What's the IP ? [ENTER]:"
read IP

#System checking if IP is found
if grep $IP * -lR
then
	echo "IP Exist in the above file (s)"
	exit
    else
	        echo "IP not found"
		echo "Adding new IP '$IP' to the list '$file_name.txt'"
		echo "$IP" >> $file_name.txt
fi

#Git add and git commit
git add .
git commit -m "Pushing repo back to GitHub"

#Git push to remote branch
echo "Pushing repo back to GitHub"
git push origin kikpeni

#Check if s3 bucket exists if not create it
echo "Check if s3 bucket '$s3_bucket' exists"
BUCKET_EXISTS=$(aws s3api head-bucket --bucket $s3_bucket 2>&1 || true)
if [ -z "$BUCKET_EXISTS" ]; then
	  echo "Bucket 's3_bucket' exists !!!"
  else
	    echo "Bucket 's3_bucket' does not exist, Creating it...."
	    aws s3 mb s3://$s3_bucket
fi
#Save a copy of new iplist file to S3 bucket
echo "Copying $file_name.txt to $s3_bucket"
aws s3 cp $file_name.txt s3://$s3_bucket
