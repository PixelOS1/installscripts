#!/bin/bash
useradd user
usermod -aG sudo user
ufw disable

# Get the UID of the "user" account
USERID=$(id -u user)

# Set environment variables
echo "USERID=$USERID" >> /etc/environment
