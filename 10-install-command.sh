#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1 #give other than 0 upto 127
else
    echo "You are running with root access"
fi

dnf list installed mysql
echo "Is MySQL installed or not?: $?"
if ( $? -ne 0 )
then
    echo "MySQL is not installed...installing it now"
     
    dnf install mysql -y
    echo "status of the mysql installation: $?"
    if ( $? -eq 0 )
    then
        echo "MySQL installation is.....SUCCESS"
    else     
        echo "MySQL installation is.....FAILURE"
        exit 1
    fi  
else   
    echo "MySQL is already installed...nothing to do"
fi    