# dev-vhost

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


