#!/bin/bash

# This script demonstrates a basic while loop

counter=20
while [ $counter -le 30 ]
do
    echo "Counter: $counter"
    ((counter++))
done

echo "All done"