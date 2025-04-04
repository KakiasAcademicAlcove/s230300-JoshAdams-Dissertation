FROM elasticsearch:8.17.4

# USER root

# Update container
# RUN apt-get update && apt-get upgrade -y && apt-get install -y curl adduser

# Install Elasticsearch
# RUN curl -L https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.17.4-linux-x86_64.tar.gz

# RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.17.4-amd64.deb
# RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.17.4-amd64.deb.sha512
# RUN shasum -a 512 -c elasticsearch-8.17.4-amd64.deb.sha512 

# COPY binaries/elasticsearch-8.17.4-amd64.deb tmp/elasticsearch.deb
# RUN dpkg -i tmp/elasticsearch.deb
# RUN apt-get install -f -y
# RUN rm -f /tmp/elasticsearch.deb

USER root

COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

# Install Chef 
# RUN apt-get update && apt-get install -y curl && \
#     curl -L https://omnitruck.cinc.io/install.sh | bash

# Ensure the chef-client binary is in the PATH
# ENV PATH="/opt/chef/bin:${PATH}"

# Verify Chef Installation (this is optional but useful for troubleshooting)
RUN chef-client --version

# Copy over Cinc files
COPY chef/ opt/cinc/

USER elasticsearch

# Create cookbooks directory
# RUN mkdir -p /opt/chef/cookbooks

# CMD ["sleep", "infinity"]

# Environment variables
# ENV discovery.type=single-node \
#     xpack.security.enabled=false \
#     ES_JAVA_OPTS="-Xms1g -Xmx1g"

# Permissions for mounted data
# RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

# As Elasticsearch user
# USER elasticsearch

# Expose Elasticsearch port
# EXPOSE 9200

# Run Elasticsearch
CMD ["bin/elasticsearch"]