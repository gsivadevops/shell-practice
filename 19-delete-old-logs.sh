#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR=/home/ec2-user/app-logs

echo "logs folder: $LOGS_FOLDER"
echo "script name: $SCRIPT_NAME"
echo "log file: $LOG_FILE"


mkdir -p $LOGS_FOLDER

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo "You are running with root access" | tee -a $LOG_FILE
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

echo "Script started executing at $(date)" | tee -a $LOG_FILE

#FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14) #14 days old files
#FILES_TO_DELETE=$(find "$SOURCE_DIR" -name "*.log" -mmin +5) #5mins old files

# echo "FILES_TO_DELETE: $FILES_TO_DELETE"

# while IFS= read -r filepath
# do
#     echo "Deleting file: $filepath" | tee -a "$LOG_FILE"
#     rm -rf "$filepath"
# #done <<< $FILES_TO_DELETE #with this files not deleting, so use below done
# done <<< "$FILES_TO_DELETE"

FILES_TO_DELETE=$(find "$SOURCE_DIR" -type f -name "*.log" -mmin +5)
echo "FILES_TO_DELETE: $FILES_TO_DELETE"

#if file name contains spaces or new lines also, then below code will work, and this code is memory efficient
find "$SOURCE_DIR" -name "*.log" -mmin +5 | while IFS= read -r filepath
do
   echo "Deleting file: $filepath" | tee -a "$LOG_FILE"
   rm -f "$filepath" #removes only files
done

VALIDATE $? "Deleting 14 days older log files"
echo "Script executed successfully"




