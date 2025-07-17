#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
   echo "ERROR::please run this script with root access"
   exit 1
else
   echo "you are running with root access"

fi

#function taking the inputs as exit status and what command they tried to install
VALIDATE(){
  if ( $1 -eq 0 )
    then
        echo "$2 installation is.....SUCCESS"
    else     
        echo "$2 installation is.....FAILURE"
        exit 1
    fi
}

#mysql installation
dnf list installed mysql
echo "Is MySQL installed or not?: $?"
if [ $? -ne 0 ]
then
    echo "MySQL is not installed...installing it now"
     
    dnf install mysql -y
    echo "status of the mysql installation: $?"
    VALIDATE $? "MySQL"
else   
    echo "MySQL is already installed...nothing to do"
fi   

#python installation
dnf list installed python3
if [ $? -ne 0 ]
then
    echo "python3 is not installed... going to install it"
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo "python3 is already installed...Nothing to do"
fi

#nginx installation
dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install it"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo "nginx is already installed...Nothing to do"
fi