FROM apache/kafka:latest

# As root
USER root

# Install Chef
RUN apk update && apk add --no-cache curl util-linux && \
    curl -L https://omnitruck.chef.io/install.sh | bash

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks