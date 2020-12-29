#!/bin/bash

q=$(zenity --entry --text=🔍)

if [ $? != 0 ]; then
  exit
fi

echo "$q" | python3 -c '
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
page = requests.get("https://duckduckgo.com/html/?%s" % urlencode({"q": q}), headers=headers).text
soup = BeautifulSoup(page, "html.parser").find_all("a", class_="result__url", href=True)
for link in soup:
    print(link["href"])' \
 | dmenu -l 5 -c -fn "Monospace-13" \
 | xclip -in -selection clipboard
