#!/bin/bash

URL_CACHE_DIR=~/.cache/urlz
IMGS_URL=https://imgs.be

# Pratique pour lire un article ou blogpost dans le terminal en évitant le
# Javascript et les pubs, pour réduire l'utilisation du microprocesseur, la
# consommation de bande passante, un petit peu l'empreinte écologique… Avec un
# cache local rudimentaire…
url() {
  local URL="$1"
  local termcols=$(tput cols)
  local dumpcols=80
  if [ $dumpcols -gt $termcols ]; then
    dumpcols=$termcols
  fi
  local offset=$((($termcols - $dumpcols)/2))
  local prefix=$(printf %${offset}c ' ')

  if [ -n "$URL" ]; then
    local fname=$(echo -n "$URL" | urlencode)
    local URLFILE="${URL_CACHE_DIR}/$fname"
    if [ -f "$URLFILE" ]; then
      zcat "$URLFILE" 2>/dev/null | sed "s/^/$prefix/" | less
    else
      curl "$URL" | \
      w3m -T text/html -cols $dumpcols -dump | \
      gzip -c | \
      tee "$URLFILE" | \
      gunzip -c | \
      sed "s/^/$prefix/" | \
      less
    fi
  fi
}

urlls(){
  find "$URL_CACHE_DIR" -type f \
    -printf "%T@ " \
    -exec sh -c "echo -n \$(basename {}) | urldecode" \; \
    -printf " %Td/%Tm/%Ty %TH:%TM " \
    -exec sh -c "echo scale=1\; \$(stat -c %s {})/1024.00 | bc -l | tr -d '\\n' " \; \
    -exec sh -c "echo K" \; \
  | sort -rn \
  | cut -d' ' -f2-
}

urlrm(){
  local OPTS=""
  if [ "$1" == "-f" ]; then OPTS="-f"; shift; fi
  while [ ${#@} -ne 0 ]; do
    local URL="$1"
    if [ -n "$URL" ]; then
      local fname=$(echo -n "$URL" | urlencode)
      local URLFILE="${URL_CACHE_DIR}/$fname"
      rm $OPTS "$URLFILE"
    fi
  shift
  done
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
    curl -L -o "$O" "$URL"
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

imgs() {
  remotefile=$(curl -X POST -F image=@"$1" ${IMGS_URL}/upload)
  echo ${IMGS_URL}/${remotefile}
}
