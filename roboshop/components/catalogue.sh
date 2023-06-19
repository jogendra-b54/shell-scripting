#!/bin/bash

COMPONENT=catalouge
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

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

echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

echo -n "Configuring the $COMPONENT repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -   &>>$LOGFILE
stat $?



#echo -e "********************* \e[35m $COMPONENT --Node JS --Installation is Started   \e[0m ********************* : "

echo -n "Installation NodeJS Started : "
yum install nodejs -y   &>> $LOGFILE
stat $?

id $APPUSER &>> $LOGFILE
if [ $? -ne 0 ] ; then
echo -n "Creating the service Account : "
useradd $APPUSER  &>> $LOGFILE
stat $?
else
echo -n "$APPUSER service Account already exist: "