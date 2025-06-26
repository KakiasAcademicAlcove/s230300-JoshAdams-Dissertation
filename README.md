# A Proof-of-Concept Data Pipeline and Monitoring System based on FreeRADIUS
## Project details
This project has been built as part of the dissertation.

It utilises Dockerised FreeRADIUS, Apache Kafka, and the Elastic Stack all deployed using Docker Compose.

## Architecture
<img width="1000" alt="image" src="https://github.com/user-attachments/assets/901c56b7-509e-4854-be14-3a3af66b5c90" />

## Run the project yourself
### Dependencies
1. Install Docker (https://www.docker.com/products/docker-desktop/)
2. Increase Docker resources (in settings) as required
      (This project has been developed locally on Mac using **8** CPU cores and **12GB** RAM)
3. Create a file called **.env** in the project root directory with the contents of **.env.example** (make the desired changes for your environment)
4. That's it! Everything else is handled by Docker internally
 
### Build containers
docker compose up -d

### Destroy containers (with volumes)
docker compose down -v

### Run CINC Auditor test infrastructure
docker compose -f docker-compose.yml -f docker-compose.test.yml up -d

Check output in logs: docker logs -f cinc-auditor

### Destroy CINC Auditor test infrastructure
docker compose -f docker-compose.yml -f docker-compose.test.yml down -v
### Enter a container
docker exec -it my-container /bin/bash

### FreeRADIUS
#### Generate some test data
/etc/freeradius/test_data/test_data_generator.sh

#### Generate a test authentication request with **radtest**
radtest mytestuser password 127.0.0.1 1812 testing123

#### Generate a test accounting request with **radclient**
radclient localhost acct testing123 < /etc/freeradius/test_data/my-acct-packet.txt

### Kafka
#### List topics
/opt/kafka/bin/kafka-topics.sh --bootstrap-server my-kafka-node:9092 --list --command.config /etc/kafka/secrets/my-kafka-node-ssl.properties

#### Create topic
/opt/kafka/bin/kafka-topics.sh --create --topic my_new_topic --bootstrap-server my-kafka-node:9092 --partitions 3 --replication-factor 3 --command.config /etc/kafka/secrets/my-kafka-node-ssl.properties

#### Consume data
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server my-kafka-node:9092 --topic my_topic --from-beginning --consumer.config /etc/kafka/secrets/my-kafka-node-ssl.properties

## Useful resources
### Docker images used in this project
- FreeRADIUS (v3.2.7): https://hub.docker.com/r/freeradius/freeradius-server/
- Apache Kafka (v4.0.0): https://hub.docker.com/r/apache/kafka
- Elasticsearch (v8.17.4): https://www.docker.elastic.co/r/elasticsearch
- Kibana (v8.17.4): https://www.docker.elastic.co/r/kibana
- Logstash (v8.17.4): https://www.docker.elastic.co/r/logstash
- Metricbeat and Filebeat (v8.17.4): https://www.docker.elastic.co/r/beats
- Curl (v8.13.0): https://hub.docker.com/r/curlimages/curl
- Keytool-utils by Lucidworks (v5.9.12): https://hub.docker.com/r/lucidworks/keytool-utils
- CINC Workstation (v24.12.1073): https://hub.docker.com/u/cincproject

### Documentation
- Docker - https://docs.docker.com/
- FreeRADIUS - https://www.freeradius.org/documentation/
- Apache Kafka - https://kafka.apache.org/090/documentation.html
- Elasticsearch - https://www.elastic.co/elasticsearch
- Kibana - https://www.elastic.co/kibana
- Logstash - https://www.elastic.co/logstash
- Beats - https://www.elastic.co/beats
