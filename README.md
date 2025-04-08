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