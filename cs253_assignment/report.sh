#!/bin/bash
# Task 3: The Report Dashboard
# Summarizes targeted ports for all failed login attempts, sorted by highest attempts.

CLEAN_LOG=${1:-clean_log.csv}

echo "Target Port Analysis"
echo "--------------------"
# grep "Failed password": Filter for failed attempts.
# grep -oE 'port[ =]+[0-9]+': Extract the port section.
# grep -oE '[0-9]+': Extract just the port number.
# sort | uniq -c: Group and count them.
# sort -nr: Sort the final counts numerically in reverse (descending) order.
grep "Failed password" "$CLEAN_LOG" | grep -oE 'port[ =]+[0-9]+' | grep -oE '[0-9]+' | sort | uniq -c | sort -nr | while read count port; do
    printf "Port %-4s : %d attempts\n" "$port" "$count"
done
