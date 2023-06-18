#!/bin/bash

function x()
{
    echo "hello world"

}

function Around()
{
    echo "before"
    eval $1
    echo "after"
}

around x