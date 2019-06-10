#!/bin/bash

if [ -z ${1+x} ]
then
    echo script name missing
    exit 1
else
    script_name="$1"
fi

if [ -z ${2+x} ]
then
    outfile="out.pcap"
else
    outfile="$2"
fi


docker run -it --rm \
    -v $(pwd)/src:/usr/src/app/src \
    -v $(pwd)/out:/usr/src/app/out \
    --cap-add=SYS_ADMIN iman/puppet-master:1 \
    bash src/dispatch.sh "$script_name" "$outfile"


