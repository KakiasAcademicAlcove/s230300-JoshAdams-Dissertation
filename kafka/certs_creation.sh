#!/bin/bash

set -e

# Set certificate directory and certificate generation flag file
CERTS_DIR="/certs"
CERT_FLAG="/$CERTS_DIR/.certs_done"

# If certificates already exist then skip generation
if [ -f "$CERT_FLAG" ]; then
  echo "Kafka certs already generated. Skipping...";
  exit 0;
fi

echo "Generating Kafka certs..."

# Check that certificate password is set as an environment variable
if [ x${KAFKA_CERT_PASSWORD} == x ]; then
  echo "Set the KAFKA_CERT_PASSWORD environment variable in the .env file";
  exit 1;
fi;

# Set certificate chain variables
PASSWORD=$KAFKA_CERT_PASSWORD
DAYS=365
NODES=("kafka-1" "kafka-2" "kafka-3")
CA_KEY="$CERTS_DIR/ca.key"
CA_CRT="$CERTS_DIR/ca.crt"
KEYSTORE_PASSWORD="$PASSWORD"
TRUSTSTORE_PASSWORD="$PASSWORD"

# Make certificates directory
mkdir -p "$CERTS_DIR"

# Generate CA
echo "[0/6] Generating Certificate Authority (CA)"
openssl req -x509 -newkey rsa:4096 -sha256 -days $DAYS -nodes \
  -keyout "$CA_KEY" \
  -out "$CA_CRT" \
  -subj "/CN=Kafka-CA"

echo "[0/6] CA certificate and key generated."

# Generate certificates for each node (kafka-1, kafka-2, kafka-3)
for NODE in "${NODES[@]}"; do
  mkdir -p "$CERTS_DIR/$NODE"
  echo ""
  echo "---- Generating certs for $NODE ----"

  # Create OpenSSL config with Subject Alternative Name (SAN) for each node                   
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

  # Generate private key and CSR
  openssl req -new -nodes -newkey rsa:2048 \
    -keyout "$CERTS_DIR/$NODE/$NODE.key" \
    -out "$CERTS_DIR/$NODE/$NODE.csr" \
    -config "$CERTS_DIR/$NODE/$NODE.cnf"

  # Sign certificate with CA
  openssl x509 -req -in "$CERTS_DIR/$NODE/$NODE.csr" \
    -CA "$CA_CRT" \
    -CAkey "$CA_KEY" \
    -CAcreateserial \
    -out "$CERTS_DIR/$NODE/$NODE.crt" \
    -days $DAYS \
    -extfile "$CERTS_DIR/$NODE/$NODE.cnf" \
    -extensions v3_req

  # Create PKCS12 keystore
  openssl pkcs12 -export \
    -in "$CERTS_DIR/$NODE/$NODE.crt" \
    -inkey "$CERTS_DIR/$NODE/$NODE.key" \
    -certfile "$CA_CRT" \
    -out "$CERTS_DIR/$NODE/$NODE.p12" \
    -name "$NODE-cert" \
    -passout pass:$PASSWORD

  # Import PKCS12 into JKS keystore
  keytool -importkeystore \
    -deststorepass "$KEYSTORE_PASSWORD" \
    -destkeypass "$KEYSTORE_PASSWORD" \
    -destkeystore "$CERTS_DIR/$NODE/$NODE.keystore.jks" \
    -srckeystore "$CERTS_DIR/$NODE/$NODE.p12" \
    -srcstoretype PKCS12 \
    -srcstorepass "$PASSWORD" \
    -alias "$NODE-cert" \
    -noprompt

  # Create truststore for each node
  keytool -import -trustcacerts \
    -alias CARoot \
    -file "$CA_CRT" \
    -keystore "$CERTS_DIR/$NODE/$NODE.truststore.jks" \
    -storepass "$TRUSTSTORE_PASSWORD" \
    -noprompt
  
  # Create SSL client configs for each node
  cat > $CERTS_DIR/$NODE/$NODE-ssl.properties <<EOF
security.protocol=SSL
ssl.truststore.location=/etc/kafka/secrets/${NODE}.truststore.jks
ssl.truststore.password=${TRUSTSTORE_PASSWORD}
EOF

  echo "Done for $NODE — Keystore and Truststore created"
done

# Create a truststore for Logstash (to validate each brokers certificate)
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

# Change certificate file permissions to be owned by Kafka user (uses UID 1000)
echo "Changing permissions for Kafka user (UID 1000)..."
chown -R 1000:1000 "$CERTS_DIR"
find "$CERTS_DIR" -type f \( -name "*.jks" -o -name "*.p12" \) -exec chmod 640 {} \;
find "$CERTS_DIR" -type f -name "*.crt" -exec chmod 644 {} \;
find "$CERTS_DIR" -type f -name "*.txt" -exec chmod 640 {} \;

echo "Done. All certs and credentials are ready."

# Create certificate creation flag file to prevent regeneration in future
touch "$CERT_FLAG"
