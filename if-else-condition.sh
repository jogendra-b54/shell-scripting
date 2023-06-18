#!/bin/bash

ACTION=$1

if [ "$ACTION" == "start" ]; then
    echo -e "\e[32m starting RabbitMQ server \e[0m"
    exit 0
elif [ "$ACTION" == "restart" ]; then
    echo -e "\e[33m Restarting RabbitMQ server \e[0m"
    exit 1
elif [ "$ACTION" == "stop" ]; then
    echo -e "\e[31m Stopping the RabbitMQ server \e[0m"
    exit 2
elif [ "$ACTION" == "enable" ]; then
    echo -e "\e[36m Enabling  the RabbitMQ server \e[0m"
    exit 3
else 
    echo -e "\e[34m Available options are start---stop----restart-----enable only \e[0m"
    exit 4

fi
