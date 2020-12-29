#!/bin/bash

BROUTEUR="/home/kheops/apps/tor-browser_en-US/Browser/start-tor-browser --detach --allow-remote"
CACHE="/home/kheops/.cache/dmenu_web_search"

q=$(sort -u $CACHE | dmenu -l 10 -c -fn "Serif-14")

if [ -z "$q" ]; then
  exit
fi

echo "$q" >>$CACHE

url=$(echo "$q" | python3 -c '
import requests
from bs4 import BeautifulSoup
from sys import stdin
from urllib.parse import urlencode
q=""
for line in stdin:
  q += "%s\n" % line
headers = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:84.0) Gecko/20100101 Firefox/84.0",
}
page = requests.get("https://duckduckgo.com/html/?%s" % urlencode({"q": q, "country": "france"}), headers=headers).text
soup = BeautifulSoup(page, "html.parser").find_all("a", class_="result__url", href=True)
for link in soup:
    print(link["href"])' \
 | dmenu -l 5 -c -fn "Monospace-13")

if [ -n "$url" ]; then
  $BROUTEUR "$url"
fi
