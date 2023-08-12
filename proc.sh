#!/bin/bash

# Get a list of all running processes
processes=$(ps aux)

# Iterate through each process and print its PID, name, and start time
echo "PID  Process Name          Start Time"
echo "---  --------------------  ----------"
while read -r line; do
  # Extract the PID, name, and start time from the process info
  pid=$(echo $line | awk '{print $2}')
  name=$(echo $line | awk '{print $11}')
  start_time=$(echo $line | awk '{print $9}')

  # Truncate the process name if it is too long
  name=${name:0:20}

  # Print the PID, name, and start time
  printf "%4s  %-20s  %s\n" "$pid" "$name" "$start_time"
done <<< "$processes"
