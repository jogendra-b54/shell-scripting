#!/bin/bash

ACTION=$1

if[ "$ACTION" == "start" ]; then
echo -e "\e[32 starting RabbitMQ server \e[0m"
else
echo -e "\e[31 Available Option is start only \e[0m"
fi 
