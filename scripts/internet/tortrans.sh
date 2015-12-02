#!/bin/bash

# Warning: this script is a stub, far from complete, prone to data leak, etc.
# Don't use as-is, check before.

TORTRANSPORT=9051
TORDNSPORT=9053
TORUSER=tor

iptables -A OUTPUT \
   -m owner --uid-owner $TORUSER \
   -p tcp --syn \
   -j REDIRECT --to-ports $TORTRANSPORT

iptables -A OUTPUT \
   -m owner --uid-owner $TORUSER \
   -p udp --dport 53 \
   -j REDIRECT --to-ports $TORDNSPORT

iptables -A OUTPUT \
   -m owner --uid-owner $TORUSER \
   -j REJECT
