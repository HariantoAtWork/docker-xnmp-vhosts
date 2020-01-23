# NGINX SSL Certificates for Development

RUN: `./createNginxSslConfigFile.sh`

This will create:

- RootCA.crt
- RootCA.pem
- RootCA.key
- RootCA.srl
- localhost/localhost.crt
- localhost/localhost.key
- localhost/localhost.csr
- ../enabled/ssl.conf

Check https://www.bounca.org/tutorials/install_root_certificate.html
how to install `RootCA.(crt|pem)` and `RootCA.key` in your system

(WIP)