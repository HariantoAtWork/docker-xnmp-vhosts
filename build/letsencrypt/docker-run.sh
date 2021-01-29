#!/bin/bash

docker run --rm \
-v $PWD/config/email.txt:/root/email.txt:ro \
-v $PWD/config/domains.txt:/root/domains.txt:ro \
-v $PWD/../../data/letsencrypt:/etc/letsencrypt \
-it harianto/certbot-alpine