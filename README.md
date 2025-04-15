## Project details
## Install dependencies
## Build project
docker-compose up -d --build

# Useful resources
https://hub.docker.com/r/apache/kafka

# Run test suite:
docker compose -f docker-compose.yml -f docker-compose.test.yml up --abort-on-container-exit 
docker compose -f docker-compose.yml -f docker-compose.test.yml up --abort-on-container-exit -d

Check test logs in terminal (if not using -d flag) or in logs: docker logs -f inspec

# Setup containers for the first time:
docker compose --profile setup up --build

# Bring containers up after initial build:
docker compose up -d

# Bring containers down:
docker compose down

# Destroy everything:
docker compose -f docker-compose.yml -f docker-compose.test.yml down -v
