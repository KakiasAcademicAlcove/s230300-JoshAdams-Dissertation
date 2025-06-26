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
3. Create a file called **.env** in the project root directory based on **.env.example**
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

### Kafka
#### List topics
/opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka-1:9092 --list --command.config /etc/kafka/secrets/kafka-1-ssl.properties

#### Create topic
/opt/kafka/bin/kafka-topics.sh --create --topic my_new_topic --bootstrap-server kafka-1:9092 --partitions 3 --replication-factor 3 --command.config /etc/kafka/secrets/kafka-1-ssl.properties

#### Consume data
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka-1:9092 --topic my_topic --from-beginning --consumer.config /etc/kafka/secrets/kafka-1-ssl.properties

## Useful resources
### Docker images used in this project
1. FreeRADIUS (3.2.7) - https://hub.docker.com/r/freeradius/freeradius-server/
2. Apache Kafka (4.0.0) - https://hub.docker.com/r/apache/kafka
3. Elasticsearch (8.17.4) - https://www.docker.elastic.co/r/elasticsearch
4. Kibana (8.17.4) - https://www.docker.elastic.co/r/kibana
5. Logstash (8.17.4) - https://www.docker.elastic.co/r/logstash
6. Metricbeat and Filebeat (8.17.4) - https://www.docker.elastic.co/r/beats
7. Curl (8.13.0) - https://hub.docker.com/r/curlimages/curl
8. Keytool-utils (5.9.12) - https://hub.docker.com/r/lucidworks/keytool-utils
9. CINC Workstation (24.12.1073) - https://hub.docker.com/u/cincproject

### More information
1. FreeRADIUS - https://www.freeradius.org/documentation/
2. Apache Kafka - https://kafka.apache.org/090/documentation.html
3. Elasticsearch - https://www.elastic.co/elasticsearch
4. Kibana - https://www.elastic.co/kibana
5. Logstash - https://www.elastic.co/logstash
6. Beats - https://www.elastic.co/beats
