#!/bin/bash

#AMI_ID="ami-0c1d144c8fdd8d690"

#AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId')

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
SG_ID=$( aws ec2 describe-security-groups --filters "Name=group-name,Values=b54-allow-all" | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')
#echo -e "AMI ID used to launch the EC2 is \e[32m $AMI_ID \e[0m \033[5mYOUR_STRING\033[0m" ) for bold Italic blink

echo -e "AMI ID used to launch the EC2 is \e[32m $AMI_ID \e[0m"
echo -e "Security Group  ID used to launch the EC2 is \e[32m $SG_ID \e[0m"
# aws ec2 run-instances \
#     --image-id ami-0abcdef1234567890 \
#     --instance-type t2.micro \
#     --key-name MyKeyPair
#aws ec2 describe-security-groups --filters "Name=group-name,Values=b54-allow-all"
# aws ec2 describe-security-groups --filters "Name=group-name,Values=b54-allow-all" | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g'


echo -e " ***********Lanuching the Server ********** "
 #aws ec2 run-instances   --image-id ${AMI_ID}   --instance-type t3.micro | jq .

 #--tag-specifications 'ResourceType=instance,Tags=[{Key=webserver,Value=production}]' 'ResourceType=volume,Tags=[{Key=cost-center,Value=cc123}]'
 #aws ec2 run-instances  --image-id ${AMI_ID} --instance-type t3.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq .

 #aws ec2 run-instances  --image-id ${AMI_ID} --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq .

 aws ec2 run-instances  --image-id ${AMI_ID} --instance-type t3.micro --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g'