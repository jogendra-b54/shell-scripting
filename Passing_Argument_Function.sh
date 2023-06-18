#!/bin/bash

function one() {
    # Print the result to stdout
    #echo "$1"
    echo "Hello"
}
function two() {
    local one=$1
    local two=$2
    # Do arithmetic and assign the result to
    # a variable named result
    result=$((one + two))
    # Pass the result of the arithmetic to
    # the function "one" above and catch it
    # in the variable $1
    one "$result"
}

# Call the function "two"
two 5 3
one
