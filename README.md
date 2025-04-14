## Project details
## Install dependencies
## Build project
docker-compose up -d --build

# Useful resources
https://hub.docker.com/r/apache/kafka

# Chef binaries (if required):
COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

RUN chef-client --version

# Run test suite:
docker compose -f docker-compose.yml -f docker-compose.test.yml up --abort-on-container-exit

Check logs in: docker logs -f inspec

# Setup containers for the first time:
docker-compose up -d --build --profile setup

# Bring containers up after initial build:
docker-compose up -d

# Bring containers down:
docker-compose down

# Destroy everything:
docker compose -f docker-compose.yml -f docker-compose.test.yml down -v
