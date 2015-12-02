#!/bin/bash

# Warning: this script is a stub, far from complete, prone to data leak, etc.
# Don't use as-is, check before.

TORTRANSPORT=9051
TORDNSPORT=9053
TORUSER=tor

iptables -t nat -A OUTPUT \
   -m owner --uid-owner $TORUSER \
   -p tcp --syn \
   -j REDIRECT --to-ports $TORTRANSPORT

iptables -t nat -A OUTPUT \
   -m owner --uid-owner $TORUSER \
   -p udp --dport 53 \
   ! -d 127.0.0.1 \
   -j REDIRECT --to-ports 53

#iptables -A OUTPUT \
#   -m owner --uid-owner $TORUSER \
#   -j REJECT
