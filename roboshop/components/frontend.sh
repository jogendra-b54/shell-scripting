#!/bin/bash

COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log"

ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31m This script is executed to be run by a root user or with sudo previlage \e[0m"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m success \e[0m"
    else
        echo -e "\e[31m Failure  \e[0m"
        exit 2
    fi

}

echo -n "Installing Nginx :"

yum install nginx -y &>> $LOGFILE

stat $?

echo -n "Downloading the ${COMPONENT} component :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}./archive/main.zip"

stat $?
echo -n "Performing cleanup"
cd /usr/share/nginx/html
rm -rf * &>>  $LOGFILE

stat $?



# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -n "Extracting ${COMPONENT} component :"
unzip /tmp/${COMPONENT}.zip  &>> $LOGFILE
mv $COMPONENT-main/*  .
mv static/*  .  
rm -rf  ${COMPONENT}-main README.md
#mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

# echo -n "Starting $COMPONENT service : "
# systemctl enable nginx
# systemctl start nginx
# stat $?
