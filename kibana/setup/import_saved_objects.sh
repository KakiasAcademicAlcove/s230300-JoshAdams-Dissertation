#!/bin/bash

KIBANA_URL="http://kibana:5601"

echo "Waiting for Kibana API..."
until curl -s -o /dev/null -w "%{http_code}" "$KIBANA_URL/api/status" | grep 200; do
  sleep 3
done

echo "Kibana API is ready. Importing saved objects..."

# Import auth data view
curl -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/kibana_setup/saved_objects/auth_data.ndjson"

# Import acct data view
curl -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/kibana_setup/saved_objects/acct_data.ndjson"

echo "Import complete. Exiting container."
