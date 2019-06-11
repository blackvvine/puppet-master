#!/bin/bash

SSLFILE=/usr/src/app/out/keys.ssl

sudo touch $SSLFILE
sudo chown chrome $SSLFILE

chromium-browser --no-sandbox --headless --disable-gpu --ssl-key-log-file="$SSLFILE"

