FROM ubuntu:latest

# As root
# USER root

# Update container
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl

# Install Kafka
# RUN curl -L https://downloads.apache.org/kafka/4.0.0/kafka_2.13-4.0.0.tgz -o /tmp/kafka.tgz

# Copy Kafka binary into container
COPY binaries/kafka_2.13-4.0.0.tgz /tmp/kafka.tgz

# Extract Kafka
RUN mkdir -p /opt/kafka && tar -xzf /tmp/kafka.tgz -C /opt/kafka --strip-components=1 && rm /tmp/kafka.tgz

# Install dependencies: curl and CA certificates
# RUN apk update && apk add --no-cache curl ca-certificates && \
#     rm -rf /etc/ssl/certs && update-ca-certificates


# Install dependencies
# RUN apk update && apk add --no-cache curl bash busybox shadow 

# Install Chef Workstation (which includes `chef-client`)
# RUN curl -L https://packages.chef.io/files/stable/chef-workstation/23.9.1035/alpine/3.12/chef-workstation-23.9.1035-1.alpine3.12.x86_64.rpm -o /tmp/chef.rpm && \
#     apk add --allow-untrusted /tmp/chef.rpm && \
#     rm -f /tmp/chef.rpm

# Install Chef
# RUN apt-get update && apt-get install -y curl && \
#     curl -L https://omnitruck.chef.io/install.sh | bash

COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

RUN chef-client --version

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks

# Copy your custom entrypoint script into the container
# COPY entrypoint.sh /entrypoint.sh

# Ensure the script is executable
# RUN chmod +x /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]