#!/bin/bash

# fetch args
scriptfile=$1
pcapfile=$2

# run packet capture
sudo tcpdump -i eth0 -w "/usr/src/app/out/$pcapfile" &

# run bot script
node "src/$1.js"

# give tcpdump enough time to finish dumping so we wouldn't
# cut its writing in the middle
sleep 5

# stop packet capture
sudo killall -15 tcpdump

# keep SSL key log
sudo cp $SSLKEYLOGFILE "/usr/src/app/out/${pcapfile}.sslkeylogfile"

# keep trace
sudo cp trace/trace.json "/usr/src/app/out/${pcapfile}.trace.json"
sudo cp trace/res.txt "/usr/src/app/out/${pcapfile}.res.json"


