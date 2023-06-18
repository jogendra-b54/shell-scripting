#!/bin/bash

ACTION=$1

case $ACTION in 
    start)
        echo -e "\e[32m strating rabbitMQ services\e[0m"
        exit 0
        ;;
        stop)
        echo -e "\e[31mstopping rabbitMQ services\e[0m"
          exit 1
        ;;
        restart) 
        echo -e "\e[33m Restarting rabbitMQ services\e[0m"
          exit 2
        ;;
        *)
        echo -e "\e[35m Possible values are start or stop or restart only\e[0m"
          exit 3
        ;;  

esac