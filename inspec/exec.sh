#!/bin/bash

echo 'Running Inspec profiles.'

echo 'Running test profile for FreeRADIUS...'
inspec exec /share/freeradius --target docker://freeradius --no-create-lockfile &&

echo 'Running test profile for Logstash...'
inspec exec /share/logstash --target docker://logstash --no-create-lockfile &&

echo 'Running test profile for Kafka-1...'
inspec exec /share/kafka --target docker://kafka-1 --no-create-lockfile &&

echo 'Running test profile for Kafka-2...'
inspec exec /share/kafka --target docker://kafka-2 --no-create-lockfile &&

echo 'Running test profile for Kafka-3...'
inspec exec /share/kafka --target docker://kafka-3 --no-create-lockfile &&

echo 'Running test profile for Elasticsearch...'
inspec exec /share/elasticsearch --target docker://elasticsearch --no-create-lockfile &&

echo 'Running test profile for Kibana...'
inspec exec /share/kibana --target docker://kibana --no-create-lockfile &&

echo 'Running test profile for Filebeat...'
inspec exec /share/filebeat --target docker://filebeat --no-create-lockfile &&

echo 'Running test profile for Metricbeat...'
inspec exec /share/metricbeat --target docker://metricbeat --no-create-lockfile

echo 'Finished running InSpec profiles. All tests passed!'
