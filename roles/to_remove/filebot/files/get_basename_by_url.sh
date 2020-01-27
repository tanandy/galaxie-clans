#! /bin/bash
#URL="https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=fr"
URL=$1
MOTIF="  Location:"
wget --server-response --spider "$URL" 2>&1 | grep "$MOTIF" | head -n 1| awk -F/ '{print $NF}'
