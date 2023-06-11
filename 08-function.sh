#!/bin/bash

#functon is to capture the repeatative block

sample()
{
    echo "I am a sample function with sample name "
    echo "I am executing the sample function"
    echo "sample function is completed"
    echo "calling status function"
    status

}

status()
{
    TODAY_DATE="09JUNE2023"
    #echo "Good morning today date is $TODAY_DATE"

    var=$(date +%A%d%b)
    echo "Good morning today date is $var"

    NO_OF_SESSION=$(who | wc -l)
    echo -e "NUmber of session opened :\e[32m $NO_OF_SESSION \e[0m"

    echo "the load avarage of the system from last 1 minute : $(uptime | awk -F , '{print $3}' | awk -F : '{print $2}')"
}
    #this is how you can call a function

sample
#status