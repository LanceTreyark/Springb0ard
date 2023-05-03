#!/bin/bash
# This is for running tests 
# you can execute or edit this script with these alias commands:
# sb-test         --Run test script
# sb-etest        --Edit test script

# IPV6 -In
myIPv6=$(ip addr show | awk '/inet6 .* scope global/ {split($2, arr, "/"); print arr[1]}')
cat >/tmp/ipSorter.txt <<EOF
$myIPv6
EOF
myIP6=$(awk '{print $1}' /tmp/ipSorter.txt)
echo "The IPv6 address for this server is: $myIP6"
rm -r /tmp/ipSorter.txt
# IPV6 -Out
