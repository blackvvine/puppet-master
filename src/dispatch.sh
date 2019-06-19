#!/bin/bash


source $(dirname $0)/config.sh

# fetch args
scriptfile=$1
pcapfile=$2


while [[ true ]]
do

    if [[ "$DUMP_PCAPS" == "1" ]]
    then
        # run packet capture
        sudo tcpdump -i eth0 -w "/usr/src/app/out/$pcapfile" &
    fi

    # run bot script
    echo Running script $1
    node "src/$1.js"


    if [[ "$DUMP_PCAPS" == "1" ]]
    then
        # give tcpdump enough time to finish dumping so we wouldn't
        # cut its writing in the middle
        sleep 5

        # stop packet capture
        sudo killall -15 tcpdump
    fi


    if [[ "$DUMP_SSL" == "1" ]]
    then
        # keep SSL key log
        sudo cp $SSLKEYLOGFILE "/usr/src/app/out/${pcapfile}.sslkeylogfile"
    fi

    if [[ "$DUMP_TRACE" == "1" ]]
    then
        # keep trace
        sudo cp trace/trace.json "/usr/src/app/out/${pcapfile}.trace.json"
    fi


    if [[ "$DUMP_SPEED" == "1" ]]
    then
        # keep speed analysis
        sudo cp trace/res.txt "/usr/src/app/out/${pcapfile}.res.json"
    fi

    echo sleeping...
    sleep $SLEEP_TIME

done
