#!/bin/bash
line="./file2.txt"
while cat "$line" ; do
        # echo "$line" | grep "Total no of errors 0"
       if [ grep "Total no of errors 0" [ $? = 0 ] ] then
              echo "No Error found, Continuing with the next step."

    # Check if the log file contains any other "Total no of errors" message with a positive number
    if grep -q "Total no of errors [1-9][0-9]*" "$line"; then
        echo "  Errors found. Exiting."
        exit 1
        fi