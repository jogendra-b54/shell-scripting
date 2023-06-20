#!/bin/bash

COMPONENT="rabbitmq"

source components/common.sh

echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

echo -n "Configuring the ${COMPONENT} repo : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
stat $?


echo -n "Installing the $COMPONENT : "
yum install rabbitmq-server -y        &>>$LOGFILE

echo -n "Starting  the $COMPONENT : "
systemctl enable rabbitmq-server    &>>$LOGFILE
systemctl restart rabbitmq-server     &>>$LOGFILE
stat $?


echo -n "Creating the $COMPONENT $APPUSER : "
rabbitmq add_user roboshop roboshop123                &>>$LOGFILE
stat $?

echo -n "Configuring the $COMPONENT $APPUSER previlage : "
rabbitmqctl set_user_tags roboshop administrator                &>>$LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"       &>>$LOGFILE
stat $?




