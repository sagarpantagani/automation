#!/bin/bash

#This is for and while loops

<< comment
execute forloop.sh day 1 10
$1 is a argument 1 which is folder name
$2 is a start range
$3 is a end range

comment

echo "Start range is: $2"
echo "End range is: $3"

for (( i=$2; i<=$3; i++))
do
    mkdir "$1$i"
done

