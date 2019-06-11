# FROM zenika/alpine-chrome:with-puppeteer

FROM zenika/alpine-chrome:with-node

ARG KEYFILE="/tmp/sslkeylogfile"

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

ENV SSLKEYLOGFILE=$KEYFILE

WORKDIR /usr/src/app
COPY --chown=chrome package.json package-lock.json ./
RUN npm install
COPY --chown=chrome . ./

ENTRYPOINT ["tini", "--"]


USER root

RUN touch $KEYFILE
RUN chown chrome $KEYFILE

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
RUN echo "chrome ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER chrome

