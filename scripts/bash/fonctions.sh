#!/bin/bash

URL_CACHE_DIR=~/.cache/urlz

# Pratique pour lire un article ou blogpost dans le terminal en évitant le
# Javascript et les pubs, pour réduire l'utilisation du microprocesseur, la
# consommation de bande passante, un petit peu l'empreinte écologique… Avec un
# cache local rudimentaire…
url() {
  local URL="$1"

  if [ -n "$URL" ]; then
    local fname=$(echo -n "$URL" | base64 -w 0)
    local URLFILE="${URL_CACHE_DIR}/$fname"
    zless "$URLFILE" 2>/dev/null || \
      curl "$URL" | \
      w3m -T text/html -dump | \
      gzip -c | \
      tee "$URLFILE" | \
      gunzip -c | \
      less
  fi
}

urlls(){
  find "$URL_CACHE_DIR" -type f -exec sh -c \
    "echo \$(basename {}) | base64 -d" \; \
    -printf " %Td/%Tm/%Ty %TH:%TM %kK \\n"
}

urlrm(){
  local URL="$1"
  if [ -n "$URL" ]; then
    local fname=$(echo -n "$URL" | base64 -w 0)
    local URLFILE="${URL_CACHE_DIR}/$fname"
    rm "$URLFILE"
  fi
}

# Téléchargement rapidment un fichier, ça économise le temps d'écrire la ligne
# curl en entier :)
dl() {
  URL=$1
  O=$2
  if [ -n "$URL" ]; then
    if [ -z "$O" ]; then
      O=$(echo "$URL" | sed 's_.*/__' | sed 's/^$/index.html/')
    elif [ -d "$O" ]; then
      O="${O}/$(echo "$URL" | sed 's_.*/__' | sed 's/^$/index.html/')"
    fi
    curl -o "$O" "$URL"
  fi
}

# Prévision météo avec wttr.in
wttr() {
  WHERE="$1"
  curl -A curl/7.61.1 https://fr.wttr.in/"$WHERE"?m
}

# Maximise la fenêtre de terminal active, mais en plein écran, juste pour que ça
# rentre dans l'espace de travail du bureau (sans couvrir la barre des tâches
# etc.)
max() {
  RES=0,$(wmctrl -d | sed '/\* DG:/!d;s/.*WA: \([0-9]*\),\([0-9]*\) \([0-9]*\)x\([0-9]*\).*/\1,\2,\3,\4/')
 
  xrandr|grep '*'

  echo -n "Instruction taille : $RES. o/N ? "
  read r
  [ "$r" == "o" ] && wmctrl -r :ACTIVE: -e $RES
}

# Change la taille du terminal actif, en pixels (passer largeur et hauteurs en
# arguments)
t() {
  l=$1
  h=$2

  [ -n "$l" -a -n "$h" ] && \
  wmctrl -r :ACTIVE: -e 0,0,0,$l,$h
}

# Utilise la commande cal pour afficher le mois spécifié (1-12) de l'année
# courante
mois() {
  m=$1
  cal "$1" $(date +%Y)
}
