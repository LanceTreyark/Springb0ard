#!/bin/bash
# This is for running tests 
# you can execute or edit this script with these alias commands:
# sb-test         --Run test script
# sb-etest        --Edit test script

myIPv6=$(ip addr show | awk '/inet6 .* scope global/ {split($2, arr, "/"); print arr[1]}')
cat >/tmp/ipSort3r.txt <<EOF
$myIPv6
EOF
myIP=$(awk '{print $1}' /tmp/ipSort3r.txt)
echo "The IPv6 address for this server is: $myIP"
sudo rm -r /tmp/ipSort3r.txt

<<comment
# IPV6 -In
myIPv6=$(ip addr show | awk '{if ($2 ~ /^fe80:/) {gsub(/\/[0-9]+/,"",$2); print $2}}' | head -1)
cat >/tmp/ipSort3r.txt <<EOF
$myIPv6
EOF
myIP6=$(awk '{print $1}' /tmp/ipSort3r.txt)
echo "The IPv6 address for this server is: $myIP6"
sudo rm -r /tmp/ipSort3r.txt
# IPV6 -Out
comment