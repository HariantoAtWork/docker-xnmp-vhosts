#!/bin/bash
CERT_DIR=../certificates
ENABLED_DIR=../enabled

[ -f "$ENABLED_DIR/ssl.conf" ] && echo -e "Error Script: $ENABLED_DIR/ssl.conf already exist!" && exit 0
# RootCA
[[ ! -f "$CERT_DIR/RootCA.pem" || ! -f "$CERT_DIR/RootCA.key" ]] && ./createRootCA.sh && echo RootCA CREATED
# localhost
[[ ! -f "$CERT_DIR/localhost/localhost.crt" || ! -f "$CERT_DIR/localhost/localhost.key" ]] && ./createLocalhost.sh localhost && echo localhost.* CREATED

OUTPUT=`cat <<'EOF'
server {
	server_name ~^ssl(\.localhost)?$;
	return 301 https://$host$request_uri;
}

server {
    include /nginx/snippets/ssl-domain.conf;
	server_name ~^ssl(\.localhost)?$;

	index index.html index.php;
    root /vhosts/ssl/httpdocs;
	location / {
		try_files $uri $uri/ /index.php$is_args$args;
	}

	include /nginx/snippets/php-fpm-default.conf;
}

# SUBDOMAINS
server {
	server_name ~^((?<subdomain>.*)\.)ssl(\.localhost)?$;
	return 301 https://$host$request_uri;
}

server {
	include /nginx/snippets/ssl-domain.conf;
	server_name ~^((?<subdomain>.*)\.)ssl(\.localhost)?$;

	index index.html index.php;
	root /vhosts/ssl/subdomains/${subdomain}/httpdocs;
	location / {
		try_files $uri $uri/ /index.php$is_args$args;
	}

	include /nginx/snippets/php-fpm-default.conf;
}
EOF
`
# OUTPUT: EOF

echo -e "$OUTPUT" > $ENABLED_DIR/ssl.conf
echo DONE.