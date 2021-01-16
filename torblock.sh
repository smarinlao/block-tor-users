#!/bin/bash
cd /tmp/
echo "Get torlist to block"
wget -q -O - "https://www.dan.me.uk/torlist/" -U SXTorBlocker/1.0 > /tmp/tor.txt
sed -i 's|^#.*$||g' /tmp/tor.txt
iptables -F
for IP in `cat /tmp/tor.txt`
do
	echo $IP
	iptables -I INPUT -s $IP -j DROP
done
service iptables save