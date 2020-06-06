#!/usr/bin/env python

import socket

# Bluetooth device address and port to connect to
bt_mac = "00:11:22:33:44:55"
bt_port = 1

# UDP IP address, port and family (AF_INET6 or AF_INET) to send data to
udp_ip = "::1"
udp_port = 5599
udp_family = socket.AF_INET6

# Do a little animation every time a byte is read from bluetooth
animation = True
