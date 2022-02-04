#!/bin/bash

echo "Enable epel release"
sudo amazon-linux-extras install epel -y

echo "Installing figlet"
sudo yum install figlet -y

figlet -f slant Success
