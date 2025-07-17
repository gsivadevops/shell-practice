#!/bin/bash

USERID=$(id -u)

echo "id of the user: $USERID"
if ( $USERID -ne 0 )
then 
   echo "please run this script with root access"
   exit 1
else
   echo "you are running with root access"
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