#!/bin/bash

COMPONENT="mysql"

source components/common.sh

 echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

echo -n "Configuring the $COMPONENT Repo : "
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing the $COMPONENT :"
yum install mysql-community-server -y &>>$LOGFILE
stat $?

echo -n "Starting the $COMPONENT : "
systemctl enable mysqld &>>$LOGFILE
systemctl start mysqld &>>$LOGFILE
stat $?

echo -n "Fetching  default root password : "
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
stat $?

#mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSWORD}
#ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';
#I want this to be executed only if the default password reset was not done .
echo "show databases;" | mysql -uroot -pRoboShop@1 &>>$LOGFILE
if [ $? -ne 0 ]; then
    echo -n "Performing password reset of MySQL Root user : "
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSWORD} &>>$LOGFILE
    stat $?
else
    echo -n "Already the mysql root password has been changed : "
    stat $?
fi

echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password &>>$LOGFILE
if [ $? -eq 0 ]; then
    echo -n "Uninstalling the validate_password  plugin : "
    echo "UNINSTALL PLUGIN validate_password;" | mysql -uroot -pRoboShop@1 &>>$LOGFILE
    stat $?
    else
    echo -n "Already the mysql validate_password plugins has been Uninstalled  : "
    stat $?
fi


echo -n "Downloading the $COMPONENT Schema : "
 curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?


echo -n "Extracting the $COMPONENT Schema : "
cd /tmp
unzip -o tmp/${COMPONENT}.zip
cd ${COMPONENT}-main
mysql -u root -pRoboShop@1 <shipping.sql
stat $?

  echo -e "********************* \e[34m $COMPONENT Installation is completed  \e[0m ********************* : "


