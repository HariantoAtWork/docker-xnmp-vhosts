#!/bin/bash
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout ../RootCA.key -out ../RootCA.pem -subj "/C=NL/O=XNMP/CN=XNMP-Root-CA"
openssl x509 -outform pem -in ../RootCA.pem -out ../RootCA.crt
