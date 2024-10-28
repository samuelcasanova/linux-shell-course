#!/bin/bash

# This script show potential attackers IPs based on the amount of failed login attempts in a log file
LOG_FILE=${1}

if [[ ! -f ${LOG_FILE} ]]
then
    echo "Can't open the log file ${LOG_FILE}" >&2
    exit 1
fi

echo 'Count,IP'
awk -F ': ' '{print $2}' ${LOG_FILE} | grep "Failed password for " | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | grep -E '^\s*[0-9]{2,}\s' | awk '{print $1 "," $2}'