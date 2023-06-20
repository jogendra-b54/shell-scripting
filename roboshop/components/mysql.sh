#!/bin/bash

COMPONENT="mysql"

source components/common.sh


echo -n "Configuring the $COMPONENT Repo : "
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing the $COMPONENT :"
yum install mysql-community-server -y   &>> $LOGFILE
stat $?

echo -n "Starting the $COMPONENT : "
systemctl enable mysqld  &>> $LOGFILE
systemctl start mysqld   &>> $LOGFILE
stat $?

echo -n "Changing  default root password : "
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk  '{print $NF}' )
stat $?

echo -n "Performing password reset of MySQL Root user : "
#mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSWORD}
#ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSWORD}  &>> $LOGFILE
stat $?






