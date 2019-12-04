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
