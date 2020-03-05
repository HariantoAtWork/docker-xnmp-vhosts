docker-xnmp-vhost
=================

Docker XNMP Development

Cross-Platform (X), Nginx (N), MariaDB (M), PHP (P)

## How to

- install Docker https://www.docker.com/
- `docker-compose up`

## Notes

Available pages

- check default page: http://localhost
- check default page: http://example.com.localhost
- check default page: http://test.example.com.localhost
- check default page: http://php5.localhost
- check default page: http://php7.localhost
- check default page: http://php7-ext.localhost
- check default page: http://ssl.localhost
- check default page: http://test.ssl.localhost

> Make sure you set your host file these domains to 127.0.0.1

### Optional: Dnsmasq


File: /etc/resolver/localhost

```
127.0.0.1
```

> Create this file as user _root_


PhpMyAdmin

- check: http://localhost:8080/
- user: root, pass: root

## Docker stuff

Run shell from a running docker container


Check Docker Network

```bash
docker network ls
```

> remember `NAME` for `--net` flag

Which docker container runs my database

```bash
docker ps
```

> remember `NAMES` for `--link` flag

```bash
docker run --rm --net docker-xnmp-vhosts_default --link docker-xnmp-vhosts_db_1:db -it alpine:latest /bin/sh
```

> `db` is the custom link name (host) you want to connect later in Alpine Shell
> You will go inside Alpine Shell

### Inside Alpine Shell

```bash
# install mysql-client
apk add --update mysql-client

# open mysql shell and connect to host 'db'
mysql -h db  
```


## SSL Certificates

Make localhost domains work with HTTPS

Go to `nginx/bin` directory and run from there:

```bash
./createNginxSslConfigFile.sh
```

This will create:

- nginx/certificates/RootCA.crt
- nginx/certificates/RootCA.pem
- nginx/certificates/RootCA.key
- nginx/certificates/RootCA.srl
- nginx/certificates/localhost/localhost.crt
- nginx/certificates/localhost/localhost.key
- nginx/certificates/localhost/localhost.csr
- nginx/enabled/ssl.conf


Check https://www.bounca.org/tutorials/install_root_certificate.html
how to install `RootCA.(crt|pem)` and `RootCA.key` in your system


> After installing RootCA's you might reboot your computer, to make `localhost/localhost.*` files work for your https connections
