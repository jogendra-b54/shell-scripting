#!/bin/bash

COMPONENT=catalouge
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

echo -n "Configuring the $COMPONENT repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
stat $?
