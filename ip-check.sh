#!/bin/bash

file_name=new-iplist
s3_bucket=iplist-test

git config --global user.email "najitestech@gmail.com"
git config --global user.name "Kelvin Ikpeni"

#Git pull code from git remot branch
echo "Pulling repo from GitHub"
git pull origin kikpeni

#System prompt for IP
echo "What's the IP ?"
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
	  echo "Bucket exists"
  else
	    echo "Bucket does not exist"
fi
#Save a copy of new iplist file to S3 bucket
echo "Copying $file_name.txt to $s3_bucket"
aws s3 cp $file_name.txt s3://$s3_bucket
