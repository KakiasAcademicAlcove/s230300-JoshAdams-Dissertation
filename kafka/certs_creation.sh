#!/bin/bash

set -e

CERTS_DIR="/certs"
CERT_FLAG="/$CERTS_DIR/.certs_done"

if [ -f "$CERT_FLAG" ]; then
  echo "Kafka certs already generated. Skipping...";
  exit 0;
fi

echo "Generating Kafka certs..."

if [ x${KAFKA_CERT_PASSWORD} == x ]; then
  echo "Set the KAFKA_CERT_PASSWORD environment variable in the .env file";
  exit 1;
fi;

PASSWORD=$KAFKA_CERT_PASSWORD
DAYS=365
NODES=("kafka-1" "kafka-2" "kafka-3")
CA_KEY="$CERTS_DIR/ca.key"
CA_CRT="$CERTS_DIR/ca.crt"
KEYSTORE_PASSWORD="$PASSWORD"
TRUSTSTORE_PASSWORD="$PASSWORD"

mkdir -p "$CERTS_DIR"

# 1. Generate the Certificate Authority (CA)
echo "[0/6] Generating Certificate Authority (CA)"
openssl req -x509 -newkey rsa:4096 -sha256 -days $DAYS -nodes \
  -keyout "$CA_KEY" \
  -out "$CA_CRT" \
  -subj "/CN=Kafka-CA"

echo "[0/6] CA certificate and key generated."

# 2. Generate certificates for each broker (kafka-1, kafka-2, kafka-3)
for NODE in "${NODES[@]}"; do
  mkdir -p "$CERTS_DIR/$NODE"
  echo ""
  echo "---- Generating certs for $NODE ----"

  # 2.1 Create OpenSSL config with Subject Alternative Name (SAN) for each broker
  cat > "$CERTS_DIR/$NODE/$NODE.cnf" <<EOF
[ req ]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[ req_distinguished_name ]
CN = $NODE

[ v3_req ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $NODE
DNS.2 = localhost
EOF

  # 2.2 Generate private key and CSR
  openssl req -new -nodes -newkey rsa:2048 \
    -keyout "$CERTS_DIR/$NODE/$NODE.key" \
    -out "$CERTS_DIR/$NODE/$NODE.csr" \
    -config "$CERTS_DIR/$NODE/$NODE.cnf"

  # 2.3 Sign the certificate with the CA
  openssl x509 -req -in "$CERTS_DIR/$NODE/$NODE.csr" \
    -CA "$CA_CRT" \
    -CAkey "$CA_KEY" \
    -CAcreateserial \
    -out "$CERTS_DIR/$NODE/$NODE.crt" \
    -days $DAYS \
    -extfile "$CERTS_DIR/$NODE/$NODE.cnf" \
    -extensions v3_req

  # 2.4 Create PKCS12 keystore
  openssl pkcs12 -export \
    -in "$CERTS_DIR/$NODE/$NODE.crt" \
    -inkey "$CERTS_DIR/$NODE/$NODE.key" \
    -certfile "$CA_CRT" \
    -out "$CERTS_DIR/$NODE/$NODE.p12" \
    -name "$NODE-cert" \
    -passout pass:$PASSWORD

  # 2.5 Import PKCS12 to JKS keystore
  keytool -importkeystore \
    -deststorepass "$KEYSTORE_PASSWORD" \
    -destkeypass "$KEYSTORE_PASSWORD" \
    -destkeystore "$CERTS_DIR/$NODE/$NODE.keystore.jks" \
    -srckeystore "$CERTS_DIR/$NODE/$NODE.p12" \
    -srcstoretype PKCS12 \
    -srcstorepass "$PASSWORD" \
    -alias "$NODE-cert" \
    -noprompt

  # 2.6 Create truststore
  keytool -import -trustcacerts \
    -alias CARoot \
    -file "$CA_CRT" \
    -keystore "$CERTS_DIR/$NODE/$NODE.truststore.jks" \
    -storepass "$TRUSTSTORE_PASSWORD" \
    -noprompt
  
  # 2.7 Create SSL client configs
  cat > $CERTS_DIR/$NODE/$NODE-ssl.properties <<EOF
security.protocol=SSL
ssl.truststore.location=/etc/kafka/secrets/${NODE}.truststore.jks
ssl.truststore.password=${TRUSTSTORE_PASSWORD}
EOF

  echo "Done for $NODE — Keystore and Truststore created"
done

# 2.7 Create a truststore for Logstash (to validate Kafka broker certs)
mkdir -p "$CERTS_DIR/logstash"
LOGSTASH_TRUSTSTORE="$CERTS_DIR/logstash/logstash.truststore.jks"
echo ""
echo "[2.7] Creating Logstash truststore"
keytool -import -trustcacerts \
  -alias KafkaCA \
  -file "$CA_CRT" \
  -keystore "$LOGSTASH_TRUSTSTORE" \
  -storepass "$TRUSTSTORE_PASSWORD" \
  -noprompt

echo "Logstash truststore created at: $LOGSTASH_TRUSTSTORE"

# 3. Change permissions for Kafka user (UID 1000)
echo "Changing permissions for Kafka user (UID 1000)..."
chown -R 1000:1000 "$CERTS_DIR"
find "$CERTS_DIR" -type f \( -name "*.jks" -o -name "*.p12" \) -exec chmod 640 {} \;
find "$CERTS_DIR" -type f -name "*.crt" -exec chmod 644 {} \;
find "$CERTS_DIR" -type f -name "*.txt" -exec chmod 640 {} \;

echo "Done. All certs and credentials are ready."
touch "$CERT_FLAG"
