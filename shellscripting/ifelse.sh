#!/bin/bash

<< comment
Will be commented 
comment

#set -x

read -p "Hey Sagar what is your Goal: " DevOps

if [[ "$DevOps" == "champ" ]]; then
    echo "You are a DevOps Champion"
elif [[ "$DevOps" == "learner" ]]; then
    echo "You are a DevOps Learner"
elif [[ "$DevOps" == "Biginner" ]]; then
    echo "You are a DevOps Biginner"
else
    echo "You are not a DevOps Champion"
fi

