FROM kibana:8.17.4

# USER root

# Update container
# RUN apt-get update && apt-get upgrade -y && apt-get install -y curl adduser

# Install Kibana
# RUN curl -L https://artifacts.elastic.co/downloads/kibana/kibana-8.17.4-linux-x86_64.tar.gz

# COPY binaries/kibana-8.17.4-amd64.deb tmp/kibana.deb
# RUN dpkg -i tmp/kibana.deb
# RUN apt-get install -f -y
# RUN rm -f /tmp/kibana.deb

# Install Chef
# RUN apt-get update && apt-get install -y curl && \
#     curl -L https://omnitruck.chef.io/install.sh | bash

USER root

COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

RUN chef-client --version

# Copy over Cinc files
COPY chef/ opt/cinc/

USER kibana

# COPY cookbooks /opt/chef/cookbooks 

# Environment variables
# ENV ELASTICSEARCH_HOSTS=http://elasticsearch:9200

# Expose Kibana port
# EXPOSE 5601

# Permissions for mounted config
# RUN mkdir -p /usr/share/kibana/config && \
#     chown -R kibana:kibana /usr/share/kibana/config

# As Kibana user
# USER kibana

# Start Kibana
CMD ["bin/kibana"]