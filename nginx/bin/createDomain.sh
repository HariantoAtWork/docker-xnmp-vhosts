#!/bin/bash
OUTPUT=`cat <<EOF
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
EOF
`

COUNT=0
for ARG in "$@"
{
    (( COUNT++ ))
	OUTPUT="${OUTPUT}\nDNS.$COUNT = $ARG"
}

mkdir ../$1
echo -e "$OUTPUT" > ../$1/$1.ext 
openssl req -new -nodes -newkey rsa:2048 -keyout ../$1/$1.key -out ../$1/$1.csr -subj "/CN=localhost"
openssl x509 -req -sha256 -days 1024 -in ../$1/$1.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile ../$1/$1.ext -out ../$1/$1.crt
