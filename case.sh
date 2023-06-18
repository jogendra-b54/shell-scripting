#!/bin/bash

ACTION=$1

case $ACTION in 
    start)
        echo -e "\e[32m strating rabbitMQ services\e[0m"
        ;;
        stop)
        echo "stopping rabbitMQ services"
        ;;
        restart) 
        echo "Restarting rabbitMQ services"
        ;;
        *)
        echo "Possible values are start or stop or restart only"
        ;;  

esac