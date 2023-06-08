#!/bin/bash

# Each and every color you see on terminal will have a color code and we need to use that code baesd on our need.
# Colors       Foreground          Background

# Red               31                  41

# Green             32                  42

# Yellow            33                  43

# Blue              34                  44

# Magenta           35                  45

# Cyan              36                  46
 

# Each and every color in terminal will have a color coding

echo -e "\e[31m I am printing Red color \e[0m"
echo -e "\e[32m I am printing Green color \e[0m"
echo -e "\e[33m I am printing Yellow color \e[0m"
echo -e "\e[34m I am printing Blue color \e[0m"
echo -e "\e[35m I am printing Magenta color \e[0m"
echo -e "\e[36m I am printing Cyan color \e[0m"

#Printing backgroupd color

echo -e "\e[43;32m Iam printing Green Color with yellow Background \e[0m"