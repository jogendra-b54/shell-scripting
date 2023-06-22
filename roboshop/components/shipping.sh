#!/bin/bash

COMPONENT="shipping"

source components/common.sh

JAVA                           # Calling NodeJS Function

aws ec2 run-instances \
    --image-id ami-0abcdef1234567890 \
    --instance-type t2.micro \
    --key-name MyKeyPair