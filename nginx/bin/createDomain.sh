#!/bin/bash
CERT_DIR=../certificates
OUTPUT=`cat <<EOF
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
EOF
`
#EOF OUTPUT
COUNT=0
for ARG in "$@"
{
    (( COUNT++ ))
	OUTPUT="${OUTPUT}\nDNS.$COUNT = $ARG"
}

mkdir $CERT_DIR/$1
echo -e "$OUTPUT" > $CERT_DIR/$1/$1.ext 
openssl req -new -nodes -newkey rsa:2048 -keyout $CERT_DIR/$1/$1.key -out $CERT_DIR/$1/$1.csr -subj "/CN=localhost"
openssl x509 -req -sha256 -days 1024 -in $CERT_DIR/$1/$1.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile $CERT_DIR/$1/$1.ext -out $CERT_DIR/$1/$1.crt
