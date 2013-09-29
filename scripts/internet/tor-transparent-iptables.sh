#!/bin/bash

# IPTables rules to enable transparent forwarding into Tor of both DNS requests and TCP connections.
# Note: it's only DNS and TCP in IPv4
# All the rest is blocked for no leaking.

# Note: this script is only valid to torify requests on the local machine.

# Set the following accordingly to your torrc file:

# Tor DNSPort
TORDNS=9053

# Tor TransPort
TORTRANS=9040

# Tor Virtual address mapping
TORVIRT=127.192.0.0/10

# Set this to net interfaces potentially connected to the internet
# (we use it as we might also have VPN interfaces we dont want to interfere with)
PUBIF="eth0 wlan0"

# DNS
# Note that with a locally-running unbound server, we could do better selection of how to direct requests
# Note: you need to have an IPv4 server in resolv.conf
iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-port $TORDNS
iptables -A OUTPUT -p tcp --dport 53 -j REJECT
ip6tables -A OUTPUT -p tcp --dport 53 -j REJECT
ip6tables -A OUTPUT -p udp --dport 53 -j REJECT

# Other ideas... (the IPv6 part does not work anyway)
#for IF in $PUBIF; do
  #iptables -t nat -A OUTPUT -o $IF -p udp --dport 53 -j REDIRECT --to-port $TORDNS
  #iptables -A OUTPUT -o $IF -p tcp --dport 53 -j REJECT
#ip6tables -t mangle -A PREROUTING -p udp --dport 53 -j TPROXY --on-port $TORDNS --on-ip ::1
# previous not working so block for now
  #ip6tables -A OUTPUT -o $IF -p tcp --dport 53 -j REJECT
  #ip6tables -A OUTPUT -o $IF -p udp --dport 53 -j REJECT
#done

# IPv4 TCP redirection into tor, only for interfaces of $PUBIF
for IF in $PUBIF; do
  iptables -t nat -A OUTPUT -o $IF -p tcp -m tcp --syn -j REDIRECT --to-port $TORTRANS
  iptables -A OUTPUT -o $IF ! -p tcp -j REJECT
  # Totally block IPv6 ? Commented out by default, as Tor DNS resolves to IPv4s only, so we may want to go vanilla using explicity v6
  #ip6tables -A OUTPUT -o $IF -j REJECT
done

# For connection to .onion services
iptables -t nat -A OUTPUT -o lo -d $TORVIRT -p tcp -j REDIRECT --to-port $TORTRANS
