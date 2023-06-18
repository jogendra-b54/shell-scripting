#!/bin/bash

ACTION=$1

case $ACTION in 
    start)
        echo "strating rabbitMQ services"
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

easc