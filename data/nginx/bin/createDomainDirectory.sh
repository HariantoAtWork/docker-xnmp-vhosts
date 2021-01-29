#!/bin/bash
CERT_DIR=../certificates

if [[ $# -eq 0 ]] ; then
    echo -e 'Error Script: Need argument\n\n\tEXAMPLE: ./createDomainDirectory.sh localhost'
    exit 0
fi


OUTPUT=`cat <<EOF
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = 10.10.10.20
IP.2 = 127.0.0.1
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
mkdir -p $CERT_DIR/$1
# Generate Certificates and Keys for Domain
openssl req -new -nodes -newkey rsa:2048 -keyout $CERT_DIR/$1/$1.key -out $CERT_DIR/$1/$1.csr -subj "/CN=localhost"
openssl x509 -req -sha256 -days 1024 -in $CERT_DIR/$1/$1.csr -CA $CERT_DIR/RootCA.pem -CAkey $CERT_DIR/RootCA.key -CAcreateserial -extfile domains.ext -out $CERT_DIR/$1/$1.crt