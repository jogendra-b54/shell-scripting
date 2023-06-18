#!/bin/bash

function x()
{
    echo "hello world"

}

function Around()
{
    echo "before"
   # eval $1
   var=$($1) # instead of using 'eval' we can use this way
   # echo "after"
    echo "after $var"
}

Around x

#--------------------------------------------------------------

function myfunc()
{
    local  myresult='some value'
    echo "$myresult"
}

result=$(myfunc)   # or result=`myfunc`
echo $result