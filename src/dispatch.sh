#!/bin/bash

scriptfile=$1
pcapfile=$2

sudo tcpdump -i eth0 -w "/usr/src/app/out/$pcapfile" &

node "src/$1.js"

sleep 5

sudo killall -15 tcpdump


