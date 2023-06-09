#!/bin/bash

#echo "Good morning today date is 09June 2023"

TODAY_DATE="09JUNE2023"
#echo "Good morning today date is $TODAY_DATE"

var=$(date +%A%d%b)
echo "Good morning today date is $var"

NO_OF_SESSION=$(who | wc -l)
echo -e "NUmber of session opened :\e[32m $NO_OF_SESSION \e[0m"