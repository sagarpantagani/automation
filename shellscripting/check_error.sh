#!/bin/bash

# Specify the path to the log file
logfile="./file2.txt"

# Display the contents of the log file
#echo "Contents of the log file:"
cat "$logfile"
# read logs 
# Check if the log file contains "Total no of errors 0"
if grep -q "Total no of errors 0" "$logfile"; then
    echo "No Error found, Continuing with the next step."
    # Add your next steps here
else
    # Check if the log file contains any other "Total no of errors" message with a positive number
    if grep -q "Total no of errors [1-9][0-9]*" "$logfile"; then
        echo "  Errors found. Exiting."
        exit 1
    fi
fi