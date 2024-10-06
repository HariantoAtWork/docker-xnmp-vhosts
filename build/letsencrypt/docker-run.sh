#!/bin/sh
# docker volume create --name=letsencrypt

docker run --rm \
-v $PWD/config/email.txt:/root/email.txt:ro \
-v $PWD/config/domains.txt:/root/domains.txt:ro \
-v letsencrypt:/etc/letsencrypt \
-it harianto/certbot-alpine