#!/bin/bash

docker run --rm \
-v $PWD/config/email.txt:/root/email.txt:ro \
-v $PWD/config/domains.txt:/root/domains.txt:ro \
-v $PWD/data:/etc/letsencrypt \
-it harianto/certbot-alpine