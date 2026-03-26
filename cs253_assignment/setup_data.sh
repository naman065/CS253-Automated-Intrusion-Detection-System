#!/bin/bash

# Create the whitelist.txt
echo -e "10.0.0.5\n192.168.1.50" > whitelist.txt

# Create the initial auth.log with the exact snippet from the PDF
cat << 'EOF' > auth.log
2026-02-18 09:00:01, $ip=192.168.1.100$, user root, status Failed password, port=22
2026-02-18 09:00:02| $ip=192.168.1.100|$ user=root| status Failed password port=22
[CORRUPT-DATA] 0x89234 garbage binary data
2026-02-18 09:01:00, $ip=10.0.0.5$, user dev_team, status Failed password, port=8080
2026-02-18 09:01:01 $ip=10.0.0.51$ user=admin| status Failed password | port=8080
2026-02-18 09:02:00, $ip=172.16.0.20$, user alice, status Failed password, port=443
2026-02-18 09:02:02, $ip=172.16.0.20$, user alice, status Success, port=443
EOF

# Append extra lines to hit the thresholds for the expected output
# 192.168.1.100 needs 20 total failures (already has 2, adding 18)
for i in {1..18}; do
    echo "2026-02-18 09:05:00, \$ip=192.168.1.100$, user hacker, status Failed password, port=22" >> auth.log
done

# 45.33.22.11 needs 13 total failures
for i in {1..13}; do
    echo "2026-02-18 09:10:00, \$ip=45.33.22.11$, user unknown, status Failed password, port=22" >> auth.log
done

# 10.0.0.5 needs 15 total failures (already has 1, adding 14)
for i in {1..14}; do
    echo "2026-02-18 10:15:00, \$ip=10.0.0.5$, user dev_team, status Failed password, port=8080" >> auth.log
done

echo "Test data generated: whitelist.txt and auth.log"
