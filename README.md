## Project details
## Install dependencies
## Build project
docker compose --profile setup up --build -d

# Useful resources
https://hub.docker.com/r/apache/kafka

# Run CINC Auditor test suite
docker compose -f docker-compose.yml -f docker-compose.test.yml up -d

Check output in logs: docker logs -f cinc-auditor

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
