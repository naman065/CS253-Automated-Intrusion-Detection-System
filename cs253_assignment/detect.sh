#!/bin/bash
# Task 2: The Brute Force Detector
# Identifies attackers and generates a firewall rules script.

CLEAN_LOG=$1
WHITELIST=$2
OUTPUT_FILE=$3

# Clear the output file if it already exists from a previous run
> "$OUTPUT_FILE"

# Step 1 & 2: Identify attackers and count their "Failed password" attempts.
# grep "Failed password": Only look at failed attempts.
# grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+': Extract just the IP addresses.
# sort | uniq -c: Count the occurrences of each unique IP.
grep "Failed password" "$CLEAN_LOG" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort | uniq -c | while read count ip; do
    
    # Threshold check: strictly more than 10 failed attempts
    if [ "$count" -gt 10 ]; then
        
        # Step 3: Whitelist Cross-Reference using a manual shell loop
        is_whitelisted=0
        while read -r allowed_ip; do
            # Skip empty lines in whitelist and check for exact match
            if [ -n "$allowed_ip" ] && [ "$ip" == "$allowed_ip" ]; then
                is_whitelisted=1
                break
            fi
        done < "$WHITELIST"
        
        # Step 4: Action - If not whitelisted, append the iptables rule
        if [ "$is_whitelisted" -eq 0 ]; then
            echo "iptables -A INPUT -s $ip -j DROP # Blocked after $count failed attempts" >> "$OUTPUT_FILE"
        fi
    fi
done
