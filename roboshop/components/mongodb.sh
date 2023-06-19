#!/bin/bash

COMPONENT=mongodb
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

#1. Setup MongoDB repos.

#```bash
# curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo


#1. Install Mongo & Start Service.
# yum install -y mongodb-org
# systemctl enable mongod
# systemctl start mongod
echo -n "Configuring the $COMPONENT repo : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n " Installing  $COMPONENT  : "
yum install -y $COMPONENT-org  &>>$LOGFILE
stat $?


echo -n "Enabling the DB visibilty : "
sed -i -e 's/127.0.0.1/0.0.0.0/' mongod.conf
stat $?


echo -n "Starting $COMPONENT : "
systemctl enable mongod &>>$LOGFILE
systemctl start mongod &>>$LOGFILE
stat $?
