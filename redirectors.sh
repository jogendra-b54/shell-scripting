#!/bin/bash

# Redirectors are of 2 types in bash 
#     1) Input Redirector   ( Means take input from the file )        :    <   ( Ex : sudo mysql </tmp/studentapp.sql )
#     2) Output Redirector  ( Means routing the output to a file )    :    > or 1>    >>  ( >> appends the latest output to the existing content)

# Outputs :  
#     1) Standout Output 
#     2) Standout Error                                               : 2> captures only the standard error   
#     3) Standout output and error                                    : &> This captures both errors and standard output 

ls -ltr    >   op.txt   # Redirects the output to the op.txt file 
ls -ltr   >>   op.txt   # Redirects the output  to op.txt file by appending to the existing content
ls -ltr   &>   op.txt   # Redirects both standardOut and standardErrors 
ls -ltr   2>   op.txt   # Redirects only the standard errors.