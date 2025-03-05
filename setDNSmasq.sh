#!/bin/bash
cat <<EOF > ~/.dnsmasq.conf 
port=5053
#interface=enp6s0
# Listen on all network interfaces
domain-needed
#listen-address=127.0.0.1
# listen-address=$(hostname -i)
listen-address=0.0.0.0

#bind-interfaces

# Add domain-specific address
address=/pong.42wolfsburg.de/127.0.0.1

#Upstream DNS servers
server=10.51.1.253
server=127.0.0.53
# Enable logging
log-queries
log-facility=/home/$USER/dnsmasq.log  

# Set DNS cache size
cache-size=1000
EOF
cat ~/.dnsmasq.conf 
systemctl --user restart dnsmasq
systemctl --user status dnsmasq