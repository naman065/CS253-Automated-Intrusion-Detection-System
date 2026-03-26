#!/bin/bash
# Task 4: The Threat Timeline
# Aggregates failed login attempts by hour.

CLEAN_LOG=$1

# grep "Failed password": Filter failed attempts.
# awk -F' ' '{print $2}': Extract the time part of the timestamp (e.g., 09:00:01).
# awk -F':' '{print $1}': Extract just the two-digit hour (e.g., 09).
# sort | uniq -c: Count the occurrences of each hour.
grep "Failed password" "$CLEAN_LOG" | awk -F' ' '{print $2}' | awk -F':' '{print $1}' | sort | uniq -c | while read count hour; do
    # Print in the expected format
    printf "Hour %s: %d failed attempts\n" "$hour" "$count"
done
