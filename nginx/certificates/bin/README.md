# NGINX SSL Certificates for Development

RUN: `./createNginxSslConfigFile.sh`

This will create:

- ../RootCA.crt
- ../RootCA.pem
- ../RootCA.key
- ../RootCA.srl
- ../localhost/localhost.crt
- ../localhost/localhost.key
- ../localhost/localhost.csr
- ../../enabled/ssl.conf

Check https://www.bounca.org/tutorials/install_root_certificate.html
how to install `RootCA.(crt|pem)` and `RootCA.key` in your system


> After installing RootCA's you might reboot your computer, to make `localhost/localhost.*` files work for your https connections

## custom DNS

Copy `dns.txt.example` to `dns.txt` and add/remove domains to your wishes
And run: `./createLocalhost.sh localhost`
Restart your NGINX: `docker-compose restart nginx` in the root project (Where `docker-compose.yml` is)

(WIP)