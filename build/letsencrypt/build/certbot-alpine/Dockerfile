FROM alpine:latest

RUN apk add --no-cache --update \
    certbot \
    bash

ENV HOME=/root
WORKDIR $HOME

ADD docker-entrypoint.sh $HOME

ENTRYPOINT ~/docker-entrypoint.sh
