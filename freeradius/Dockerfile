# Start from the official FreeRADIUS image
FROM freeradius/freeradius-server:latest

# Install Chef
RUN apt-get update && apt-get install -y curl && \
    curl -L https://omnitruck.chef.io/install.sh | bash

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks

# Expose FreeRADIUS ports
EXPOSE 1812/udp 1813/udp

# Run FreeRADIUS in debug mode
CMD ["freeradius", "-X"]