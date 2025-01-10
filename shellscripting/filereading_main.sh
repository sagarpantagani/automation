#!/bin/bash

# Check if the log file path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

logfile="$1"
# logfile=$(command)

# Display the contents sof the log file
echo "Contents of the log file:"
cat "$logfile"

# Check if the log file contains "Total no of errors 0"
if grep -q "Total no of errors 0" "$logfile"; then
    echo "No Error found, Continuing with the next step."
    # Add your next steps here
else
    # Check if the log file contains any other "Total no of errors" message with a positive number
    if grep -q "Total no of errors [1-9][0-9]*" "$logfile"; then
        echo "Errors found. Exiting."
        exit 1
    fi
fi
