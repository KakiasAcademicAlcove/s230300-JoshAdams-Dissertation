#!/bin/bash

echo 'Running profiles.'

echo 'Running profile for FreeRADIUS...'
cinc-auditor exec /cinc-auditor/profiles/freeradius.rb --target docker://freeradius --no-create-lockfile

echo 'Running profile for Logstash...'
cinc-auditor exec /cinc-auditor/profiles/logstash.rb --target docker://logstash --no-create-lockfile

echo 'Running profile for Kafka-1...'
cinc-auditor exec /cinc-auditor/profiles/kafka.rb --target docker://kafka-1 --no-create-lockfile

echo 'Running profile for Kafka-2...'
cinc-auditor exec /cinc-auditor/profiles/kafka.rb --target docker://kafka-2 --no-create-lockfile

echo 'Running profile for Kafka-3...'
cinc-auditor exec /cinc-auditor/profiles/kafka.rb --target docker://kafka-3 --no-create-lockfile

echo 'Running profile for Elasticsearch...'
cinc-auditor exec /cinc-auditor/profiles/elasticsearch.rb --target docker://elasticsearch --no-create-lockfile

echo 'Running profile for Kibana...'
cinc-auditor exec /cinc-auditor/profiles/kibana.rb --target docker://kibana --no-create-lockfile

echo 'Running profile for Filebeat...'
cinc-auditor exec /cinc-auditor/profiles/filebeat.rb --target docker://filebeat --no-create-lockfile

echo 'Running profile for Metricbeat...'
cinc-auditor exec /cinc-auditor/profiles/metricbeat.rb --target docker://metricbeat --no-create-lockfile

echo 'Finished running profiles. Success!'
