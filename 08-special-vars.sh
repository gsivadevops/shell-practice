#!/bin/bash

echo "All variables passed to the script: $@"
echo "Number of variables passed: $#"
echo "script-name: $0"
echo "current directory: $PWD"
echo "user running this script: $USER"
echo "Home direcyory of user: $HOME"
echo "PID of the script: $$"
sleep 10 &
echo " PID of the last command in background: $!"
echo " The exit status of the last command executed: $?"
