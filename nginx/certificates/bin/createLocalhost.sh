#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo -e 'Error Script: Need argument\n\n\tEXAMPLE: ./createLocalhost.sh localhost'
    exit 0
fi


OUTPUT=`cat <<EOF
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
EOF
`
# OUTPUT: EOF

# Import dns.txt file if exist, else use dns.txt.example and make newline as a array and sort
DNSTXT=dns.txt
[ ! -f "$DNSTXT" ] && DNSTXT=dns.txt.example
IFS=$'\r\n' GLOBIGNORE='*' command eval 'DOMAINS=($(sort <"$DNSTXT"))'; unset IFS

for DNS in "${DOMAINS[@]}"
{
    (( COUNT++ ))
	OUTPUT="${OUTPUT}\nDNS.$COUNT = $DNS"
}
echo -e "$OUTPUT"
echo -e "$OUTPUT" > domains.ext

# Create Dir
mkdir $1
# Generate Certificates and Keys for Domain
openssl req -new -nodes -newkey rsa:2048 -keyout $1/$1.key -out $1/$1.csr -subj "/CN=localhost"
openssl x509 -req -sha256 -days 1024 -in $1/$1.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile domains.ext -out $1/$1.crt