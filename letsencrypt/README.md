# Letsencrypt Certificate Maker

Little more automation with multiple domains and wildcards

## Build Once

Run

```bash
# Buld a docker image: harianto/certbot
./docker-build.sh
```


## Config Files

In `config` directory you’ll find `.example` files or create:
`email.txt` and `domains.txt`

### email.txt

Create `email.txt`

```txt
you@domain.ext
```
> Put your email address where Letsencrypt can notify you when your ceritifcates almost expires


### domains.txt

Create `domains.txt`

```txt
domain.ext *.domain.ext
domain2.ext *.domain2.ext *.sub1.domain2.ext *.sub2.domain2.ext
```
> Each line need to be unique domain as `domain` DOT `ext` name, and follow subdomains that needs a wildcard `*`. 
> For example: `*.domain.ext`

## Create certificates

Make sure you already build once with `docker-build.sh`. 

Also you put your valid email.txt and domains.txt.

Run

```bash
# run image harianto/certbot-alpine
./docker-run.sh
```
> This will run in Interactive Shell mode while you need to follow and have time to set up your DNS tables
> All letsencrypt magic will be stored in `data` directory

## Notes

Make sure **docker-compose.yml** link correct folders in `nginx:`

```yml
service:
  nginx:
    volumes:
      - ./letsencrypt/data:/etc/letsencrypt:ro
```
> Snippet: `docker-compose.yml`

