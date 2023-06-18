#!/bin/bash

COMPONENT=frontend

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m This script is executed to be run by a root user or with sudo previlage \e[0m"
    exit 1
fi

echo "Installing Nginx :"

yum install nginx -y &>> "/tmp/${COMPONENT}.log"

if [ $? -eq 0 ] ; then
    echo -e "\e[32m success \e[0m"
else
    echo -e "\e[31m Failure  \e[0m"
fi

echo -n "Downloading the Frontend components :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

if [ $? -eq 0 ] ; then
    echo -e "\e[32m successfully downloaded \e[0m"
else
    echo -e "\e[31m Download Failure  \e[0m"
fi

# if the script is executed as root user or sudo user . then it has to proceed
# if not that mean when script runs as normal user , it should display a nice  message
# The frontend is the service in RobotShop to serve the web content over Nginx.

# Install Nginx.

# ```
# # yum install nginx -y
# # systemctl enable nginx
# # systemctl start nginx

# ```

# Let's download the HTDOCS content and deploy it under the Nginx path.
