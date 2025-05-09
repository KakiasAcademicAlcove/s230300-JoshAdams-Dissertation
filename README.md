# Project Details
ELK Kafka FreeRADIUS stack built using Docker Compose v3

# Dependencies
## 1. Install Docker Desktop 
    Mac - https://docs.docker.com/desktop/setup/install/mac-install/
    Windows - https://docs.docker.com/desktop/setup/install/windows-install/
    Ubuntu - https://docs.docker.com/desktop/setup/install/linux/ubuntu/

## 2. In Docker Desktop, go to Settings -> Resources and increase as needed. This project was developed and tested on x86 Mac using:
    CPUs: 6
    Memory: 12.00 GB
    Swap: 2 GB

# Useful resources
## Apache Kafka
### Docker Image
https://hub.docker.com/r/apache/kafka

### Documentation
https://kafka.apache.org/documentation/

## Elasticsearch

### Docker Image
https://hub.docker.com/_/elasticsearch
### Guide
https://www.elastic.co/docs/get-started

# Build project
docker compose --profile setup up --build -d

# Run test suite without test data (with auto destroy):
docker compose -f docker-compose.yml -f docker-compose.test.yml up --abort-on-container-exit 

# Run test suite with test data (infrastructure stays up for manual testing)
docker compose -f docker-compose.yml -f docker-compose.test.yml --profile setup up -d

Check test logs in terminal (if not using -d flag) or in logs: docker logs -f inspec

# Destroy test infrastructure:
docker compose -f docker-compose.yml -f docker-compose.test.yml --profile setup down -v

# Setup containers for the first time:
docker compose --profile setup up --build

# Bring containers up after initial build:
docker compose up -d

# Bring containers down:
docker compose down

# Destroy everything:
docker compose -f docker-compose.yml -f docker-compose.test.yml --profile setup down -v

## Access Kibana
http://localhost:5601

# Default credentials
Username: elastic
Password: changeme
