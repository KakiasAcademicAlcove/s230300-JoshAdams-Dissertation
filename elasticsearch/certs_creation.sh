#!/bin/bash

# Set certificate creation flag file
CERT_FLAG="config/certs/.certs_done"

# If file exists, skip generating certificates
if [ -f "$CERT_FLAG" ]; then
  echo "Elastic certs already generated. Skipping...";
  exit 0;
fi

# Check if elastic and kibana user passwords are set as environment variables
if [ x${ELASTIC_PASSWORD} == x ]; then
    echo "Set the ELASTIC_PASSWORD environment variable in the .env file";
    exit 1;
elif [ x${KIBANA_PASSWORD} == x ]; then
    echo "Set the KIBANA_PASSWORD environment variable in the .env file";
    exit 1;
fi;

# Generate CA
if [ ! -f config/certs/ca.zip ]; then
    echo "Creating CA";
    bin/elasticsearch-certutil ca --silent --pem -out config/certs/ca.zip;
    unzip config/certs/ca.zip -d config/certs;
fi;

# Generate certs for required instances (elasticsearch)
if [ ! -f config/certs/certs.zip ]; then
    echo "Creating certs";
    bin/elasticsearch-certutil cert --silent --pem \
        -out config/certs/certs.zip \
        --in /elastic_certs_setup/instances.yml \
        --ca-cert config/certs/ca/ca.crt \
        --ca-key config/certs/ca/ca.key;
    unzip config/certs/certs.zip -d config/certs;
fi;

# Ensure only root user can read and write certs, group members can only enter the directories and read, and other users cannot access
echo "Setting file permissions"
chown -R root:root config/certs;
find . -type d -exec chmod 750 \{\} \;;
find . -type f -exec chmod 640 \{\} \;;

# Wait for Elasticsearch available before sending request to API
echo "Waiting for Elasticsearch availability";
until curl -s --cacert config/certs/ca/ca.crt https://elasticsearch:9200 \
        | grep -q "missing authentication credentials"; do sleep 30; done;

# Set "kibana_system" password via POST request to API (Kibana user that communicates with Elasticsearch)
echo "Setting kibana_system password";
until curl -s -X POST \
        --cacert config/certs/ca/ca.crt \
        -u "${ELASTIC_USER}:${ELASTIC_PASSWORD}" \
        -H "Content-Type: application/json" \
        https://elasticsearch:9200/_security/user/kibana_system/_password \
        -d "{\"password\":\"${KIBANA_PASSWORD}\"}" \
        | grep -q "^{}"; do sleep 10; done;

echo "All done!";

# Create certificate creation flag file to prevent regeneration in future
touch "$CERT_FLAG"
