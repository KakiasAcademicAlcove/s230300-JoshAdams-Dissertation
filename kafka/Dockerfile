FROM apache/kafka:4.0.0

# Update container
# RUN apt-get update && apt-get upgrade -y && apt-get install -y curl openjdk-17-jre-headless

# Copy Kafka binary into container
# COPY binaries/kafka_2.13-4.0.0.tgz /tmp/kafka.tgz

# Extract Kafka
# RUN mkdir -p /opt/kafka && tar -xzf /tmp/kafka.tgz -C /opt/kafka --strip-components=1 && rm /tmp/kafka.tgz

# Install Cinc (Chef Alternative)
# RUN apk add --no-cache dpkg
# COPY binaries/cinc_18.6.2-1_amd64.deb /tmp/cinc.deb
# RUN dpkg -i /tmp/cinc.deb && rm -f /tmp/cinc.deb

# Verify install
# RUN chef-client --version

# Copy over Cinc files
# COPY chef/ opt/cinc/

# Create log directory
# RUN mkdir -p /var/lib/kafka /var/log/kafka

# COPY server1.properties /opt/kafka/config/server.properties

# Generate Cluster ID and Format Storage
# RUN KAFKA_CLUSTER_ID=$(/opt/kafka/bin/kafka-storage.sh random-uuid) && \
#     echo "Using Kafka Cluster ID: $KAFKA_CLUSTER_ID" && \
#     /opt/kafka/bin/kafka-storage.sh format \
#     --cluster-id "$KAFKA_CLUSTER_ID" \
#     --config /opt/kafka/config/server.properties \
#     --ignore-formatted \
#     --initial-controllers 1@kafka-node-1:9093,2@kafka-node-2:9093

# CMD ["/opt/kafka/bin/kafka-server-start.sh", "/opt/kafka/config/server.properties"]
