FROM alpine:latest

RUN apk add --no-cache --update \
    certbot \
    bash

ENV HOME=/root
WORKDIR $HOME

ADD sh/renew-crt.sh $HOME

ENTRYPOINT ~/renew-crt.sh
