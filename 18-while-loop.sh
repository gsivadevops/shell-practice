#!/bin/bash

# a=0

# while [ $a -lt 10 ]
# do
#    echo $a
#    a=`expr $a + 1`
# done

while IFS= read -r line
do
    echo $line
#done < 17-set-cmd.sh

done < 19-delete-old-logs.sh #for this its reading this file line by line as out put

done <<< "19-delete-old-logs.sh"