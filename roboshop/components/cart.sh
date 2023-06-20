#!/bin/bash

COMPONENT="cart"

source components/common.sh

echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

echo -n "Configuring the $COMPONENT repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -   &>>$LOGFILE
stat $?



#echo -e "********************* \e[35m $COMPONENT --Node JS --Installation is Started   \e[0m ********************* : "

echo -n "Installation NodeJS Started : "
yum install nodejs -y   &>> $LOGFILE
stat $?

id $APPUSER &>> $LOGFILE
if [ $? -ne 0 ] ; then
echo -n "Creating the service Account : "
useradd $APPUSER  &>> $LOGFILE
stat $?
else
echo -n "$APPUSER service Account already exist: "
stat $?
fi


# $ curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
# $ cd /home/roboshop
# $ unzip /tmp/catalogue.zip
# $ mv catalogue-main catalogue
# $ cd /home/roboshop/catalogue
# $ npm install
echo -n "Downloading the $COMPONENT component : "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Copying the $COMPONENT to $APPUSER home directory : "
cd /home/${APPUSER}/
rm -rf ${COMPONENT}  &>> $LOGFILE
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE
stat $?

echo -n "Modifying the ownership  : "
mv $COMPONENT-main/ $COMPONENT
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT/
stat $?

echo -n "Generating npm $COMPONENT artifact  : "
cd /home/${APPUSER}/${COMPONENT}
npm install   &>> $LOGFILE
stat $?

echo -n "Updating the $COMPONENT systemd file   : "
#sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/'   /home/${APPUSER}/${COMPONENT}/systemd.service
#sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/'  -e  's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service
mv /home/${APPUSER}/${COMPONENT}/systemd.service  /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the ${COMPONENT} service : "
systemctl daemon-reload      &>> $LOGFILE
systemctl enable $COMPONENT  &>> $LOGFILE
systemctl restart $COMPONENT  &>> $LOGFILE
stat $?



echo -e "********************* \e[34m $COMPONENT Installation is completed  \e[0m ********************* : "