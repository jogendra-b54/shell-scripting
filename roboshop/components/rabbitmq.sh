#!/bin/bash

COMPONENT="rabbitmq"

source components/common.sh

echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

echo -n "Configuring the ${COMPONENT} repo : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>$LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOGFILE
stat $?

echo -n "Installing  $COMPONENT : "
yum install rabbitmq-server -y &>>$LOGFILE
stat $?

echo -n "Starting  the $COMPONENT : "
systemctl enable rabbitmq-server &>>$LOGFILE
systemctl restart rabbitmq-server &>>$LOGFILE
stat $?

#This needs to run only if the user account doesn't exist
rabbitmqctl list_users | grep roboshop &>>$LOGFILE
if [ $? -ne 0 ]; then
    echo -n "Creating the $COMPONENT $APPUSER : "
    rabbitmqctl add_user roboshop roboshop123 &>>$LOGFILE
    stat $?
else
    echo -n "Already the Roboshop user account created in RabbitMQ server   : "
    stat $?
fi

echo -n "Configuring the $COMPONENT $APPUSER previlage : "
rabbitmqctl set_user_tags roboshop administrator &>>$LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOGFILE
stat $?


   echo -e "********************* \e[34m $COMPONENT Installation is completed  \e[0m ********************* : "