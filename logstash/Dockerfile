# Use the official Logstash image as the base
FROM logstash:8.17.3

# Install Chef
RUN apt-get update && apt-get install -y curl && \
    curl -L https://omnitruck.chef.io/install.sh | bash

# Create cookbooks directory
RUN mkdir -p /opt/chef/cookbooks

# Environment variables
ENV LOGSTASH_JAVA_OPTS="-Xmx1g -Xms1g"
ENV XPACK_MONITORING_ENABLED="false"

# Copy Logstash pipeline configurations -> this needs to be done by Chef in the long run
COPY ./logstash/pipeline/ /usr/share/logstash/pipeline/

# Ensure correct permissions for pipeline configurations
RUN chown -R logstash:logstash /usr/share/logstash/pipeline/

# Expose Logstash port
EXPOSE 5044

# Run Logstash (in the foreground -f)
CMD ["logstash", "-f", "/usr/share/logstash/pipeline/logstash.conf"]
