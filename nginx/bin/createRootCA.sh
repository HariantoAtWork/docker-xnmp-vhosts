#!/bin/bash
CERT_DIR=../certificates
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout $CERT_DIR/RootCA.key -out $CERT_DIR/RootCA.pem -subj "/C=NL/O=XNMP/CN=XNMP-Root-CA"
openssl x509 -outform pem -in $CERT_DIR/RootCA.pem -out $CERT_DIR/RootCA.crt
