#!/bin/bash

# Set up audit rules to monitor events
auditctl -a always,exit -F arch=b64 -S execve -k suspicious_processes
auditctl -a always,exit -F arch=b64 -S bind,connect -k unusual_network_activity
auditctl -w /etc -p wa -k etc_changes
auditctl -w /tmp -p wxa -k suspicious_files

# Function to execute the Python keylogger script
run_keylogger() {
  python /home/fadi/keylogger.py 
}

# Monitor audit log for events
while true; do
  # Handle events here
  
  if [ $? -eq 0 ]
  then
      echo "No changes detected at $(date)" >> /home/fadi/outp_detect.txt
  else
      echo "Changes detected at $(date) " >> /home/fadi/outp_detect.txt
      echo "Username: $(whoami) " >> /home/fadi/outp_detect.txt
      echo "Machine IP: $(hostname -I) " >> /home/fadi/outp_detect.txt
      echo "" >> /home/fadi/outp_detect.txt
      c
  fi
  run_keylogger
done
