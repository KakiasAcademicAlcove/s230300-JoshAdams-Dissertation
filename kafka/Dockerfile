FROM apache/kafka:latest

# USER root

# Install Chef
# RUN apt-get update && apt-get install -y curl && \
#     curl -L https://omnitruck.chef.io/install.sh | bash

RUN apk update && apk add curl util-linux && \
    curl -L https://omnitruck.chef.io/install.sh | bash

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks

RUN mkdir -p /var/lib/kafka/logs

ENV CLUSTER_ID=04e8b998-ab48-492b-a4f8-a622f681f0a2

# Create Kafka logs and configuration directories
# RUN mkdir -p /var/lib/kafka/logs /opt/kafka/config/kraft

# Copy over default KRaft configuration
# RUN cp /opt/kafka/config/server.properties /opt/kafka/config/kraft/

# Expose Kafka ports
EXPOSE 9092 9093

# Define entrypoint script to initialize Kafka
# CMD ["sh", "-c", "/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties"]

# Ensure cluster ID persists across restarts
# CMD ["/bin/sh", "-c", "if [ ! -f /var/lib/kafka/cluster_id ]; then \
#         echo \"$CLUSTER_ID\" > /var/lib/kafka/cluster_id && \
#         echo \"Using new cluster ID: $CLUSTER_ID\" && \
#         /opt/kafka/bin/kafka-storage.sh format -t $CLUSTER_ID -c /opt/kafka/config/server.properties --initial-controllers 1@kafka-node-1:9093,2@kafka-node-2:9093 \
#     else \
#         export CLUSTER_ID=$(cat /var/lib/kafka/cluster_id) && \
#         echo \"Using existing cluster ID: $CLUSTER_ID\"; \
#     fi && \
#     /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties --controller-quorum-voters 1@kafka-node-1:9093,2@kafka-node-2:9093"]
CMD ["/bin/sh", "-c", "if [ ! -f /var/lib/kafka/cluster_id ]; then \
        echo \"$CLUSTER_ID\" > /var/lib/kafka/cluster_id && \
        echo \"Using new cluster ID: $CLUSTER_ID\" && \
        /opt/kafka/bin/kafka-storage.sh format -t $CLUSTER_ID -c /opt/kafka/config/server.properties --initial-controllers 1@kafka-node-1:9093,2@kafka-node-2:9093; \
    else \
        export CLUSTER_ID=$(cat /var/lib/kafka/cluster_id) && \
        echo \"Using existing cluster ID: $CLUSTER_ID\"; \
    fi && \
    /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties --controller-quorum-voters 1@kafka-node-1:9093,2@kafka-node-2:9093"]
