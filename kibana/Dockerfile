FROM kibana:8.17.3

# Install Chef
RUN apt-get update && apt-get install -y curl && \
    curl -L https://omnitruck.chef.io/install.sh | bash

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks

# Environment variables
ENV ELASTICSEARCH_HOSTS=http://elasticsearch:9200

# Expose Kibana port
EXPOSE 5601

# Permissions for mounted config
RUN mkdir -p /usr/share/kibana/config && \
    chown -R kibana:kibana /usr/share/kibana/config

# As Kibana user
USER kibana

# Start Kibana
CMD ["bin/kibana"]