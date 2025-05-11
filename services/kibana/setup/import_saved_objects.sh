#!/bin/bash

KIBANA_URL="http://kibana:5601"

if [ "$SSL_ENABLED" == "true" ]; then
  echo "Waiting for Elasticsearch..."

  # Wait for Elasticsearch to be up before making user API request
  until curl -s --cacert /certs/ca/ca.crt https://elasticsearch:9200 | grep -q "missing authentication credentials"; do sleep 30; done;
  echo "Elasticsearch is up."

  # Create user for Kibana API access
  echo "Creating Kibana setup user..."

  # Check if user already exists
  if curl -s -u "$ELASTIC_USER:$ELASTIC_PASSWORD" --cacert /certs/ca/ca.crt "$ELASTICSEARCH_URL/_security/user/$KIBANA_SUPERUSER" | grep -q "$KIBANA_SUPERUSER"; then
    echo "User $KIBANA_SUPERUSER already exists. Skipping creation."
  else
    echo "Creating user $KIBANA_SUPERUSER..."
    curl -v -u "$ELASTIC_USER:$ELASTIC_PASSWORD" --cacert /certs/ca/ca.crt -X POST "$ELASTICSEARCH_URL/_security/user/$KIBANA_SUPERUSER" \
      -H "Content-Type: application/json" \
      -d '{
        "password" : "'"$KIBANA_SUPERUSER_PASSWORD"'",
        "roles" : [ "kibana_admin" ],
        "full_name" : "Kibana Super User"
      }'
  fi

  echo "Waiting for Kibana API..."

  until curl -s -u "$KIBANA_SUPERUSER:$KIBANA_SUPERUSER_PASSWORD" -o /dev/null -w "%{http_code}" "$KIBANA_URL/api/status" | grep 200; do sleep 3; done

  echo "Kibana API is ready. Importing saved objects..."

  for file in auth_data_view.ndjson acct_data_view.ndjson container_logs_data_view.ndjson container_metrics_data_view.ndjson; do
    echo "Importing $file"
    curl -u "$KIBANA_SUPERUSER:$KIBANA_SUPERUSER_PASSWORD" -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
      -H "kbn-xsrf: true" \
      -H "Content-Type: multipart/form-data" \
      -F "file=@/kibana_setup/saved_objects/$file"
  done

  echo "Import complete. Exiting container."
  exit 0;
fi

echo "Waiting for Kibana API..."
until curl -s -o /dev/null -w "%{http_code}" "$KIBANA_URL/api/status" | grep 200; do
  sleep 3
done

echo "Kibana API is ready. Importing saved objects..."

# Import auth data view
curl -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/kibana_setup/saved_objects/auth_data_view.ndjson"

# Import acct data view
curl -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/kibana_setup/saved_objects/acct_data_view.ndjson"

# Import container logs (Filebeat) data view
curl -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/kibana_setup/saved_objects/container_logs_data_view.ndjson"

# Import container metrics (Metricbeat) data view
curl -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/kibana_setup/saved_objects/container_metrics_data_view.ndjson"

echo "Import complete. Exiting container."
