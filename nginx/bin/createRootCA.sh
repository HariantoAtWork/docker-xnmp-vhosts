#!/bin/bash
CERT_DIR=../certificates
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout $CERT_DIR/RootCA.key -out $CERT_DIR/RootCA.pem -subj "/C=NL/O=XNMP/CN=XNMP-Root-CA"
openssl x509 -outform pem -in $CERT_DIR/RootCA.pem -out $CERT_DIR/RootCA.crt

COMMAND_CP_CA_CERTIFICATES_TO_SYSTEM="cp $CERT_DIR/RootCA.crt /usr/local/share/ca-certificates && update-ca-certificates -f"
if [[ -d /usr/local/share/ca-certificates ]]; then
   [[ $EUID -ne 0 ]] && sudo bash -c "$COMMAND_CP_CA_CERTIFICATES_TO_SYSTEM" || "$COMMAND_CP_CA_CERTIFICATES_TO_SYSTEM"
   echo "#--- RootCA.crt copied to /usr/local/share/ca-certificates and Updated"
fi