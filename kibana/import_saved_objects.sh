#!/bin/bash

echo "Waiting for Elasticsearch..."

# Wait for Elasticsearch before sending API request
until curl -s --cacert /certs/ca/ca.crt https://elasticsearch:9200 | grep -q "missing authentication credentials"; do sleep 30; done;
echo "Elasticsearch is up."

# Creating super user for Kibana API access
echo "Creating Kibana setup user..."

# Check if Kibana Super User already exists
if curl -s -u "$ELASTIC_USER:$ELASTIC_PASSWORD" \
      --cacert /certs/ca/ca.crt \
      "$ELASTICSEARCH_URL/_security/user/$KIBANA_SUPERUSER" \
      | grep -q "$KIBANA_SUPERUSER"; then
        echo "User $KIBANA_SUPERUSER already exists. Skipping creation."

# If Kibana Super User does not exist...
else
  # Create Kibana Super User (with "kibana_admin" role)
  echo "Creating user $KIBANA_SUPERUSER..."
  curl -v -u "$ELASTIC_USER:$ELASTIC_PASSWORD" \
      --cacert /certs/ca/ca.crt \
      -X POST "$ELASTICSEARCH_URL/_security/user/$KIBANA_SUPERUSER" \
      -H "Content-Type: application/json" \
      -d '{
        "password" : "'"$KIBANA_SUPERUSER_PASSWORD"'",
        "roles" : [ "kibana_admin" ],
        "full_name" : "Kibana Super User"
      }'
fi

# Wait for Kibana API to ready before sending request
echo "Waiting for Kibana API..."
until curl -s -u "$KIBANA_SUPERUSER:$KIBANA_SUPERUSER_PASSWORD" \
    -o /dev/null \
    -w "%{http_code}" \
    "$KIBANA_URL/api/status" \
    | grep 200; do sleep 3; done

echo "Kibana API is ready. Importing saved objects..."

# Once Kibana API is ready, import all saved objects (looping through "saved_objects" directory) with POST requests
for file in /kibana_setup/saved_objects/*.ndjson; do
  echo "Importing $file"
  curl -u "$KIBANA_SUPERUSER:$KIBANA_SUPERUSER_PASSWORD" -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
    -H "kbn-xsrf: true" \
    -H "Content-Type: multipart/form-data" \
    -F "file=@$file"
done

echo "Import complete. Exiting container."
