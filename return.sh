#!/bin/bash


 sample()
 {
    echo "I am messaged called from sample function"
 }
 stat()
 {
    echo -e "\t Total No. of session : $(who | wc -l)"
    echo "Todays date is $(date +%F)"
    echo "Load average on the system is $(uptime | awk -F : '{print $NF}' | awk -F, '{print $1}')"
    echo -e "\t stat function completed"
    echo "Calling sample function"

    exit 2  
    #return 
    sample
 }

 stat

 echo -e "\t\t Stat and Sample functions are completed"
 