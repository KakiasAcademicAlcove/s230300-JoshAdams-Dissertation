#!/bin/bash

echo "Running CINC Auditor profiles."

# List of services
services=(
    freeradius
    logstash
    kafka-1
    kafka-2
    kafka-3
    elasticsearch
    kibana
    filebeat
    metricbeat
)

# Run respective profile for each service
for service in "${services[@]}"; do
    echo "Running profile for $service..."
    cinc-auditor exec "/cinc-auditor/profiles/${service}.rb" --target "docker://${service}" --no-create-lockfile
done

echo 'Finished running profiles.'
