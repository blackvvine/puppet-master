# FROM zenika/alpine-chrome:with-puppeteer

# FROM zenika/alpine-chrome:with-node
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y nodejs npm

ARG KEYFILE="/tmp/sslkeylogfile"
ARG APPDIR="/usr/src/app"

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser


ENV SSLKEYLOGFILE=$KEYFILE

WORKDIR $APPDIR

COPY --chown=chrome package.json package-lock.json ./
RUN npm install
COPY --chown=chrome . ./

ENTRYPOINT ["tini", "--"]

# ====================================================== #

USER root

RUN touch $KEYFILE
RUN chown chrome $KEYFILE

RUN apt-get install -y tcpdump
RUN apt-get install -y bash
RUN apt-get install -y sudo
RUN apt-get install -y curl
RUN apt-get install -y screen

RUN npm install -g promisify

RUN mkdir -p $APPDIR/out/
RUN mkdir -p $APPDIR/data/

VOLUME $APPDIR/out/

RUN chown -R chrome $APPDIR/
RUN chmod 755 $APPDIR/out/

RUN curl -o $APPDIR/data/google-10000-english.txt https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english.txt

RUN echo "chrome ALL=(ALL) NOPASSWD: /usr/sbin/tcpdump" >> /etc/sudoers
RUN echo "chrome ALL=(ALL) NOPASSWD: /usr/bin/killall" >> /etc/sudoers
RUN echo "chrome ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER chrome

RUN mkdir trace

RUN npm i --save speedline
