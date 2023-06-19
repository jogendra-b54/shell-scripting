#!/bin/bash

COMPONENT=redis

source components/common.sh


echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

# curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
# yum install redis-6.2.11 -y

echo -n "Configuring the $COMPONENT repo : "
curl -s -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo 
stat $?

echo -n "Installing  $COMPONENT  : "
yum install ${COMPONENT}-6.2.11 -y   &>>$LOGFILE
stat $?

#Update the BindIP from 127.0.0.1 to 0.0.0.0 in config file /etc/redis.conf & /etc/redis/redis.conf
echo -n "Enabling the DB visibilty : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/${COMPONENT}.conf
stat $?


echo -n "Starting $COMPONENT : " 
systemctl daemon-reload $COMPONENT  &>>$LOGFILE
systemctl enable  $COMPONENT  &>>$LOGFILE
systemctl restart  $COMPONENT  &>>$LOGFILE
stat $?


echo -e "********************* \e[34m $COMPONENT Installation is completed  \e[0m ********************* : "