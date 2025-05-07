## Project details
## Install dependencies
## Build project
docker compose --profile setup up --build -d

# Useful resources
https://hub.docker.com/r/apache/kafka

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
