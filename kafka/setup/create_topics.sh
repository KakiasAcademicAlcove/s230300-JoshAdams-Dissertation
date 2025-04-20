#!/bin/bash

# echo 'Listing topics...'
# /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka-1:9092 --list

# echo 'Creating topics...'
# /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka-1:9092 --create --if-not-exists --topic freeradius_auth_accept
# /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka-1:9092 --create --if-not-exists --topic freeradius_auth_reject
# /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka-1:9092 --create --if-not-exists --topic freeradius_acct

echo 'Final list of topics:'
/opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka-1:9092 --list
