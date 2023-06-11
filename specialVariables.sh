#!/bin/bash

# special variables gives special properties to your variables

# Here are the few special variables :  $0 to $9 , $? $# $* $@


#echo $0   #==> executed the script name your are executing
echo "Name of the script executed  is : $0"
echo "Name of the student is : $1"
echo "Name of the Training batch is : $2"
echo "Current topics is  : $3"
echo "\n"
echo "\nDisplaying all the special varriables "

echo "the used variables are :$*"
echo "the exist code of this script is: $? "
echo "the total number of arguments is: $# "
echo "the PID of the script is : $$"
echo "it will display all the arguemnts  $@ "
