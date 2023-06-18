#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m This script is executed to be run by a root user or with sudo previlage"
    exit 1
fi

echo "Installing Nginx :"

yum install nginx -y

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
