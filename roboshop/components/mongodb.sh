#!/bin/bash

COMPONENT=mongodb

source components/common.sh

#1. Setup MongoDB repos.

#```bash
# curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo

#1. Install Mongo & Start Service.
# yum install -y mongodb-org
# systemctl enable mongod
# systemctl start mongod

echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

echo -n "Configuring the $COMPONENT repo : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing  $COMPONENT  : "
yum install -y $COMPONENT-org &>>$LOGFILE
stat $?

echo -n "Enabling the DB visibilty : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT : "
systemctl daemon-reload mongod &>>$LOGFILE
systemctl enable mongod mongod &>>$LOGFILE
systemctl restart mongod mongod &>>$LOGFILE
stat $?

#Download the schema and inject it.
# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js

echo -n "Downloading the $COMPONENT schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT Schema : "
cd /tmp
unzip -o mongodb.zip &>>$LOGFILE
stat $?


echo -n "Injecting the $COMPONENT schema : "
cd $COMPONENT-main
mongo <catalogue.js &>>$LOGFILE
mongo <users.js &>>$LOGFILE
stat $?


echo -e "********************* \e[34m $COMPONENT Installation is completed  \e[0m ********************* : "