# A Proof-of-Concept Data Pipeline and Monitoring System based on FreeRADIUS
## Project details
This project has been built as part of the Dissertation.

It utilises Dockerised FreeRADIUS, Apache Kafka, and the Elastic Stack all deployed using Docker Compose.

## Run the project yourself
### Dependencies
1. Install Docker (https://www.docker.com/products/docker-desktop/)
2. Increase Docker resources (in settings) as required
      This project has been developed locally on Mac using **8** CPU cores and **12GB** RAM
3. That's it! Everything else is handled by Docker internally
 
### Build containers
docker compose up -d

### Destroy containers (with volumes)
docker compose down -v

### Run CINC Auditor test infrastructure
docker compose -f docker-compose.yml -f docker-compose.test.yml up -d

Check output in logs: docker logs -f cinc-auditor

### Destroy CINC Auditor test infrastructure
docker compose -f docker-compose.yml -f docker-compose.test.yml down -v

## Useful resources
### Docker images used in this project
FreeRADIUS - https://hub.docker.com/r/freeradius/freeradius-server/
Apache Kafka - https://hub.docker.com/r/apache/kafka
Elasticsearch - https://www.docker.elastic.co/r/elasticsearch
Kibana - https://www.docker.elastic.co/r/kibana
Logstash - https://www.docker.elastic.co/r/logstash
Beats - https://www.docker.elastic.co/r/beats
Curl - https://hub.docker.com/r/curlimages/curl
Keytool-utils - https://hub.docker.com/r/lucidworks/keytool-utils
CINC Workstation - https://hub.docker.com/u/cincproject
