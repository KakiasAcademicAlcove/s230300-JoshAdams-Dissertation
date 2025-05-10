#!/bin/bash

echo 'Running Inspec profiles.'

echo 'Running test profile for FreeRADIUS...'
inspec exec $INSPEC_PROFILES_DIR/freeradius.rb --target docker://freeradius --no-create-lockfile

echo 'Running test profile for Logstash...'
inspec exec $INSPEC_PROFILES_DIR/logstash.rb --target docker://logstash --no-create-lockfile

echo 'Running test profile for Kafka-1...'
inspec exec $INSPEC_PROFILES_DIR/kafka.rb --target docker://kafka-1 --no-create-lockfile

echo 'Running test profile for Kafka-2...'
inspec exec $INSPEC_PROFILES_DIR/kafka.rb --target docker://kafka-2 --no-create-lockfile

echo 'Running test profile for Kafka-3...'
inspec exec $INSPEC_PROFILES_DIR/kafka.rb --target docker://kafka-3 --no-create-lockfile

echo 'Running test profile for Elasticsearch...'
inspec exec $INSPEC_PROFILES_DIR/elasticsearch.rb --target docker://elasticsearch --no-create-lockfile

echo 'Running test profile for Kibana...'
inspec exec $INSPEC_PROFILES_DIR/kibana.rb --target docker://kibana --no-create-lockfile

echo 'Running test profile for Filebeat...'
inspec exec $INSPEC_PROFILES_DIR/filebeat.rb --target docker://filebeat --no-create-lockfile

echo 'Running test profile for Metricbeat...'
inspec exec $INSPEC_PROFILES_DIR/metricbeat.rb --target docker://metricbeat --no-create-lockfile

echo 'Finished running InSpec profiles.'
