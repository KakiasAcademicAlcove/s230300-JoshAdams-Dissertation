#!/bin/sh
set -e

KAFKA_LOG_DIRS="/var/lib/kafka/logs"
KAFKA_CONFIG_FILE="/opt/kafka/config/server.properties"

# Check if meta.properties exists
if [ ! -f "$KAFKA_LOG_DIRS/meta.properties" ]; then
  echo "Initializing Kafka storage directory..."
  /opt/kafka/bin/kafka-storage.sh format -t $(uuidgen) -c $KAFKA_CONFIG_FILE
else
  echo "Kafka storage directory already initialized."
fi

# Start Kafka
exec /opt/kafka/bin/kafka-server-start.sh $KAFKA_CONFIG_FILE
