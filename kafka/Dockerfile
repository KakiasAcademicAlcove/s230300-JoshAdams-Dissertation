FROM apache/kafka:latest

# Install Chef
RUN apt-get update && apt-get install -y curl && \
    curl -L https://omnitruck.chef.io/install.sh | bash

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks

# Create Kafka logs and configuration directories
RUN mkdir -p /var/lib/kafka/logs /opt/kafka/config/kraft \
    && chown -R kafka:kafka /var/lib/kafka/logs /opt/kafka/config/kraft

# Copy over default KRaft configuration
COPY /opt/kafka/config/server.properties /opt/kafka/config/kraft/server.properties

# Expose Kafka ports
EXPOSE 9092 9093

# Define entrypoint script to initialize Kafka
CMD ["sh", "-c", "/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/kraft/server.properties"]