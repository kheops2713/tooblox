#!/usr/bin/env python

# Connects to a Bluetooth device, reads data from it, sends it to a UDP socket.
# Useful for GPS devices.

from sys import stdout
import bluetooth
import socket
import btudp_config
from btudp_config import bt_mac, bt_port, udp_ip, udp_port, udp_family, animation

udp_addr = (udp_ip, udp_port)
bt_addr = (bt_mac, bt_port)
display_ip = "{}{}{}".format('[' if udp_family == socket.AF_INET6 else '',
                             udp_ip,
                             ']' if udp_family == socket.AF_INET6 else '')
anim_char = "🚲"
anim_cnt = 0
anim_width = 15

while True:
  nearby_devices = bluetooth.discover_devices()
  if bt_mac in nearby_devices:
    break

btsock = bluetooth.BluetoothSocket (bluetooth.RFCOMM)
btsock.connect(bt_addr)

print (f"Connecté à {bt_mac}, port {bt_port}")

udpsock = socket.socket(udp_family, socket.SOCK_DGRAM)

print (f"Envoi vers udp://{display_ip}:{udp_port}")

while True:
  try:
    data = btsock.recv(1)
    if animation:
      stdout.write ("\r{}{}{}".format(" "*anim_cnt, anim_char[0], " "*(anim_width-anim_cnt-1)))
      stdout.flush()
      anim_cnt = (anim_cnt + 1)%anim_width
    udpsock.sendto (data, udp_addr)
  except Exception as e:
    print (e.message)
    break
  except BaseException as e:
    print (type(e))
    break

btsock.close()
