#!/bin/bash

COMPONENT=frontend

source components/common.sh

echo -n "Installing Nginx :"

yum install nginx -y &>>$LOGFILE

stat $?

echo -n "Downloading the ${COMPONENT} component :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

stat $?
echo -n "Performing cleanup"
cd /usr/share/nginx/html
rm -rf * &>>$LOGFILE

stat $?

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -n "Extracting ${COMPONENT} component :"
unzip /tmp/${COMPONENT}.zip &>>$LOGFILE
mv $COMPONENT-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Updating the Backend component ReverseProxy details : "
for component in catalogue; do
    sed -i -e "/$component/s/localhost/$component.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
done
stat $?


echo -n "Starting $COMPONENT service : "
systemctl daemon-reload  &>>$LOGFILE
systemctl enable nginx    &>>$LOGFILE
systemctl restart nginx   &>>$LOGFILE
stat $?



echo -e "********************* \e[34m $COMPONENT Installation is completed  \e[0m ********************* : "