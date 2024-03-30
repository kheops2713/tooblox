#!/bin/bash
#
# Script basique pour changer d'adresse MAC et supprimer le bail DHCP de
# NetworkManager sur l'interface réseau présentement active avec NM, dans le but
# de changer « d'identité » sur le réseau courant. Utile pour les portails
# captifs qui limitent la quantité de données ou le temps de connexion par
# appareil. Nécessite droits root.
#
# Simple script to change MAC address and delete NetworkManager DHCP lease on
# the currently NM active interface, aiming at changing "identity" on the
# current network.  Useful for captive portals that limit either data quantity
# or connection time per device. Needs root.

set -e

while IFS=: read -a NMCONN; do
  if [ "${NMCONN[1]}" = "802-11-wireless" ]; then
    conn_uuid="${NMCONN[0]}"
    conn_type="${NMCONN[1]}"
    conn_dev="${NMCONN[2]}"

    break
  fi
done < <(nmcli -f UUID,TYPE,DEVICE --terse connection show --active)

if [ "o$conn_uuid" = "o" ]; then
  echo Pas trouvé de connexion sans fil active
  echo Could not find an active wireless connection
  exit 1
fi

conn_ssid=$(nmcli -g --terse -f GENERAL.NAME connection show "$conn_uuid")

echo "🛜 $conn_ssid"
echo "🪪 $conn_uuid (NetworkManager)"
echo "📡 $conn_dev / $(nmcli -e no -g --terse -f GENERAL.HWADDR dev show $conn_dev) / $(nmcli -e no -g --terse -f IP6.ADDRESS,IP4.ADDRESS dev show $conn_dev | xargs)"

set -x
systemctl stop NetworkManager.service
ip link set $conn_dev down
rm -fv /var/lib/NetworkManager/*-${conn_uuid}-${conn_dev}.lease
macchanger -a $conn_dev
ip link set $conn_dev up
systemctl start NetworkManager.service
sleep 20
set +x

echo "📡 $conn_dev / $(nmcli -e no -g --terse -f GENERAL.HWADDR dev show $conn_dev) / $(nmcli -e no -g --terse -f IP6.ADDRESS,IP4.ADDRESS dev show $conn_dev | xargs)"
