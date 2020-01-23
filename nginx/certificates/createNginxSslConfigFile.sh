#!/bin/bash
[ -f "../enabled/ssl.conf" ] && echo -e 'Error Script: ../enabled/ssl.conf already exist!' && exit 0

[[ ! -f "RootCA.pem" || ! -f "RootCA.key" ]] && ./createRootCA.sh && echo RootCA CREATED

[[ ! -f "localhost/localhost.crt" || ! -f "localhost/localhost.key" ]] && ./createLocalhost.sh localhost && echo localhost.* CREATED

OUTPUT=`cat <<EOF
server {
	server_name ~^ssl(\.dev|\.localhost)?$;
	return 301 https://$host$request_uri;
}

server {
    include /nginx/snippets/ssl-domain.conf;
	server_name ~^ssl(\.dev|\.localhost)?$;

	index index.html index.php;
    root /vhosts/ssl/httpdocs;
	location / {
		try_files $uri $uri/ /index.php$is_args$args;
	}

	include /nginx/snippets/php7.0.8-fpm.conf;
}

# SUBDOMAINS
server {
	server_name ~^((?<subdomain>.*)\.)ssl(\.dev|\.localhost)?$;
	return 301 https://$host$request_uri;
}

server {
	include /nginx/snippets/ssl-domain.conf;
	server_name ~^((?<subdomain>.*)\.)ssl(\.dev|\.localhost)?$;

	index index.html index.php;
	root /vhosts/ssl/subdomains/${subdomain}/httpdocs;
	location / {
		try_files $uri $uri/ /index.php$is_args$args;
	}

	include /nginx/snippets/php7.0.8-fpm.conf;
}
EOF
`
# OUTPUT: EOF

echo -e "$OUTPUT" > ../enabled/ssl.conf
echo DONE.