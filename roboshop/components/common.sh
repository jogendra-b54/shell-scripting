#!/bin/bash

LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31m This script is executed to be run by a root user or with sudo previlage \e[0m"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m success \e[0m"
    else
        echo -e "\e[31m Failure  \e[0m"
        exit 2
    fi

}

CREATE_USER() {
    id $APPUSER &>>$LOGFILE
    if [ $? -ne 0 ]; then
        echo -n "Creating the service Account : "
        useradd $APPUSER &>>$LOGFILE
        stat $?
    else
        echo -n "$APPUSER service Account already exist: "
        stat $?
    fi
}

DOWNLOAD_AND_EXTRACT() {
    echo -n "Downloading the $COMPONENT component : "
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
    stat $?

    echo -n "Copying the $COMPONENT to $APPUSER home directory : "
    cd /home/${APPUSER}/
    rm -rf ${COMPONENT} &>>$LOGFILE
    unzip -o /tmp/${COMPONENT}.zip &>>$LOGFILE
    stat $?

    echo -n "Modifying the ownership  : "
    mv $COMPONENT-main/ $COMPONENT
    chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT/
    stat $?
}

NPM_INSTALL() {
    echo -n "Generating npm $COMPONENT artifact  : "
    cd /home/${APPUSER}/${COMPONENT}
    npm install &>>$LOGFILE
    stat $?
}

CONFIGURE_SVC() {
    echo -n "Updating the $COMPONENT systemd file   : "
    #sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service
    #sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/'  -e  's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/'  /home/${APPUSER}/${COMPONENT}/systemd.service
    sed -i -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service
    mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
    stat $?

    echo -n "Starting the ${COMPONENT} service : "
    systemctl daemon-reload &>>$LOGFILE
    systemctl enable $COMPONENT &>>$LOGFILE
    systemctl restart $COMPONENT &>>$LOGFILE
    stat $?

    echo -e "********************* \e[34m $COMPONENT Installation is completed  \e[0m ********************* : "

}

NODEJS() {
    echo -e "********************* \e[35m $COMPONENT Installation is Started   \e[0m ********************* : "

    echo -n "Configuring the $COMPONENT repo : "
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>>$LOGFILE
    stat $?

    echo -n "Installation NodeJS Started : "
    yum install nodejs -y &>>$LOGFILE
    stat $?

    CREATE_USER # Calling create user function to create the roboshop user account

    DOWNLOAD_AND_EXTRACT # calling this function To Download the content

    NPM_INSTALL #  Creates Artifacts

    CONFIGURE_SVC #Configuring the service
}

MVN_PACKAGE() {
    echo -n "Preparing $COMPONENT artifacts  : "
    cd /home/${APPUSER}/${COMPONENT}
    mvn clean package &>>$LOGFILE
    mv target/shipping-1.0.jar shipping.jar &>>$LOGFILE
    stat $?

}

JAVA() {
    echo -e "********************* \e[34m $COMPONENT Installation has started   \e[0m ********************* : "

    echo -n "Installing Maven : "

    yum install maven -y &>>$LOGFILE # ( installs maven with java 8 )
    stat $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    MVN_PACKAGE

    CONFIGURE_SVC
}

PYTHON() {

    echo -e "*********** \e[35m $COMPONENT Installation has started \e[0m ***********"

    echo -n "Installing Python and its dependencies :"
    yum install python36 gcc python3-devel -y &>>$LOGFILE
    stat $?

    CREATE_USER

    DOWNLOAD_AND_EXTRACT

    echo -n "Installing $COMPONENT :"
    cd /home/${APPUSER}/${COMPONENT}/
    pip3 install -r requirements.txt      &>>$LOGFILE
    stat $?
}
