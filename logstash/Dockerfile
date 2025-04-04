# Use the official Logstash image as the base
FROM ubuntu:latest

# USER root

# Update container
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl

# Install Logstash
RUN curl -L https://artifacts.elastic.co/downloads/logstash/logstash-8.17.4-linux-x86_64.tar.gz | bash

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

# Environment variables
# ENV LOGSTASH_JAVA_OPTS="-Xmx1g -Xms1g"
# ENV XPACK_MONITORING_ENABLED="false"

# Copy Logstash pipeline configurations -> this needs to be done by Chef in the long run
# COPY ./logstash/pipeline/ /usr/share/logstash/pipeline/

# Ensure correct permissions for pipeline configurations
# RUN chown -R logstash:logstash /usr/share/logstash/pipeline/

# USER logstash

# Expose Logstash port
# EXPOSE 5044

# Run Logstash (in the foreground -f)
# CMD ["logstash", "-f", "/usr/share/logstash/pipeline/logstash.conf"]
