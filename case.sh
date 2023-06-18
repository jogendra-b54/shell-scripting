#!/bin/bash

ACTION=$1

case $ACTION in 
    start)
        echo -e "\e[32m strating rabbitMQ services\e[0m"
        ;;
        stop)
        echo -e "\e[31mstopping rabbitMQ services\e[0m"
        ;;
        restart) 
        echo "\e[33m Restarting rabbitMQ services\e[0m"
        ;;
        *)
        echo "\e[35mPossible values are start or stop or restart only\e[0m"
        ;;  

esac