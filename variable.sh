#!/bin/bash 


# What is a variable ? Variable is ised to store and pass values    


# This is how we can declare variables in Bash 
a=10 
b=20
c=30        
d=40
e=70

echo $a

echo -e "Value of the variable a is \e[32m $a \e[0m"
echo -e "Value of the variavle b is \e[32m $b \e[0m"
echo -e "Value of the variable c is \e[32m $c \e[0m"
echo -e "Value of the variable d is \e[32m ${d} \e[0m"
echo -e "Value of the variable e is \e[32m ${e} \e[0m"