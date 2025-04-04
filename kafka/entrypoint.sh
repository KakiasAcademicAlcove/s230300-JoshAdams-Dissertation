#!/bin/sh
set -e  # Exit immediately if a command fails

echo "Running Chef to configure Kafka..."
chef-client -j /path/to/node/file -E kafka || { echo "Chef failed! Exiting."; exit 1; }

echo "Starting Kafka service..."
exec /kafka/bin/kafka-server-start.sh /kafka/config/server.properties
