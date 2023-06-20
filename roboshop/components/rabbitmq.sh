#!/bin/bash

COMPONENT="rabbitmq"

source components/common.sh

echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

echo -n "Configuring the ${COMPONENT} repo : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash           &>>$LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>>$LOGFILE
stat $?


echo -n "Installing  $COMPONENT : "
yum install rabbitmq-server -y      &>> $LOGFILE 
stat $?

echo -n "Starting  the $COMPONENT : "
systemctl enable rabbitmq-server    &>>$LOGFILE
systemctl restart rabbitmq-server     &>>$LOGFILE
stat $?

#This needs to run only if the user account doesn't exist
echo -n "Creating the $COMPONENT $APPUSER : "
rabbitmqctl add_user roboshop roboshop123    &>> $LOGFILE
stat $?

echo -n "Configuring the $COMPONENT $APPUSER previlage : "
rabbitmqctl set_user_tags roboshop administrator                &>>$LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"       &>>$LOGFILE
stat $?




