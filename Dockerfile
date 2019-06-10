FROM zenika/alpine-chrome:with-puppeteer

USER root

RUN apk update
RUN apk add tcpdump
RUN apk add bash
RUN apk add sudo
RUN apk add curl

RUN mkdir -p /usr/src/app/out/
RUN chown chrome /usr/src/app/out/
RUN chmod 755 /usr/src/app/out/

VOLUME /usr/src/app/out/

RUN echo "chrome ALL=(ALL) NOPASSWD: /usr/sbin/tcpdump" >> /etc/sudoers
RUN echo "chrome ALL=(ALL) NOPASSWD: /usr/bin/killall" >> /etc/sudoers

USER chrome

