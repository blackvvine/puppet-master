#!/bin/bash

if [ -z ${1+x} ]
then
    echo script name missing
    exit 1
fi

script_name="$1"

docker run -it --rm -v $(pwd)/src:/usr/src/app/src --cap-add=SYS_ADMIN zenika/alpine-chrome:with-puppeteer node "src/$script_name.js"


