#!/bin/bash

# Pratique pour lire un article ou blogpost dans le terminal en évitant le
# Javascript et les pubs, pour réduire l'utilisation du microprocesseur, la
# consommation de bande passante, un petit peu l'empreinte écologique…
url() {
  URL="$1"
  if [ -n "$URL" ]; then
    #curl "$URL" | html2text | pandoc -t plain | less
    curl "$URL" | w3m -T text/html -dump | less
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
