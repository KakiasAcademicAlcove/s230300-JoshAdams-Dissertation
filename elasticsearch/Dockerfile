FROM elasticsearch:8.17.3

USER root

# Install Chef 
RUN apt-get update && apt-get install -y curl && \
    curl -L https://omnitruck.chef.io/install.sh | bash

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks

# Environment variables
ENV discovery.type=single-node \
    xpack.security.enabled=false \
    ES_JAVA_OPTS="-Xms1g -Xmx1g"

# Permissions for mounted data
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

# As Elasticsearch user
USER elasticsearch

# Expose Elasticsearch port
EXPOSE 9200

# Run Elasticsearch
CMD ["bin/elasticsearch"]