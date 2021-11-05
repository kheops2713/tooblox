#!/bin/sh

# interface réseau
INTERFACE=eth1

# exemple de filtre : "host 12.34.56.90" pour filtrer sur cette IP
# laisser vide pour tout capturer sur l'interfce en question
FILTRE=

# durée de l'écoute
SECONDES=300


tmpfile=/tmp/tshark-bandepassante-$(date +%s%N)
now=$(date)

# tshark produit un tableau  de statistiques
# le contenu du trafic lui-même n'est *pas* enregistré
tshark -f "$FILTRE" -i "$INTERFACE" -q -n -z io,stat,0 -a duration:$SECONDES 2>/dev/null >"$tmpfile"

# on analyse la sortie de tshark pour trouver les bons morceaux
duration=$(sed '/^| Duration:/!d;s/[^0-9.]//g' "$tmpfile")
nbytes=$(tail -n 2 "$tmpfile" | head -n 1 | cut -d\| -f4 | sed 's/[^0-9]//g;s/^$/0/')
rate=$(echo "${nbytes}/${duration}/1024" | bc -l)

echo ${now} - ${duration} s, ${nbytes} o, ${rate} Kio/s


rm -f "$tmpfile"
