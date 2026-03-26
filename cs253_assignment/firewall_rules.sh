iptables -A INPUT -s 192.168.1.100 -j DROP # Blocked after 20 failed attempts
iptables -A INPUT -s 45.33.22.11 -j DROP # Blocked after 13 failed attempts
