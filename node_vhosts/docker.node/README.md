# NGINX config

file: nginx/enabled/docker.node.conf

```conf
server {
    server_name ~^docker\.node(\.dev|\.localhost)?$;
    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://unix:/tmp/docker-node.sock:$uri$is_args$args;
        proxy_redirect off;
    }
}
```

## Starting Docker

Make sure docker is properly installed (in Ubuntu start this script as: root)

```bash
. docker-node.sh
```

> After starting this Docker, a file `tmp/docker-node.sock` will be created so NGINX could read from it

Open web: http://docker.node.localhost

> Config your hosts file this url to 127.0.0.1 or use dnsmasq

Paths

- http://docker.node.localhost/api/valtech/log
- http://docker.node.localhost/api/valtech/v1/i18n
- http://docker.node.localhost/api/valtech/v1/whitepapers
- http://docker.node.localhost/api/valtech/v1/whitepapers/id/:id
- http://docker.node.localhost/api/valtech/v1/insights
- http://docker.node.localhost/api/valtech/v1/insights/id/:id
- http://docker.node.localhost/api/valtech/v1/cases
- http://docker.node.localhost/api/valtech/v1/cases/id/:id
- http://docker.node.localhost/api/valtech/v1/jobs
- http://docker.node.localhost/api/valtech/v1/jobs/id/:id
- http://docker.node.localhost/api/valtech/v1/contacts
- http://docker.node.localhost/api/valtech/v1/contacts/id/:id
