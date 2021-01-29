#!/bin/bash

EMAIL=`cat email.txt`
SERVER=https://acme-v02.api.letsencrypt.org/directory
CERTBOTARGS="certonly --agree-tos -m $EMAIL --manual --manual-public-ip-logging-ok --preferred-challenges dns --server $SERVER"
DNSTXT=domains.txt
IFS=$'\r\n' GLOBIGNORE='*' command eval 'DOMAINS=($(<"$DNSTXT"))'; unset IFS

# cd /root/certbot
for DOMAIN in "${DOMAINS[@]}"
{
    allDNS=($DOMAIN)
    args=()
    for dns in "${allDNS[@]}"; do args+=(-d "$dns"); done

    echo "###: $DOMAIN"
    certbot $CERTBOTARGS --cert-name ${allDNS[0]} "${args[@]}"
    echo ================================

}
