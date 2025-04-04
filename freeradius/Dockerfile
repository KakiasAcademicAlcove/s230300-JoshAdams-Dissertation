# Start from Ubuntu base image
FROM ubuntu:latest

# Update container
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl

# Install FreeRADIUS
RUN apt-get install -y freeradius freeradius-ldap freeradius-mysql

# Stop FreeRADIUS server before config is applied
RUN service freeradius stop

# Install Chef
# RUN apt-get update && apt-get install -y curl && \
#     curl -L https://omnitruck.chef.io/install.sh | bash

COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

RUN chef-client --version

# Create cookbooks directory
# RUN mkdir -p /opt/cinc/cookbooks

# Copy over Cinc files
COPY chef/ opt/cinc/

# RUN chef-client --local-mode --override-runlist "role[deploy-freeradius]" --why-run 
# RUN cd /opt/cinc/cookbooks/freeradius && chef-client --local-mode --override-runlist "recipe[freeradius::default]"

CMD ["freeradius", "-f"]

# Expose FreeRADIUS ports
# EXPOSE 1812/udp 1813/udp

# Run FreeRADIUS in debug mode
# CMD ["freeradius", "-X"]
# CMD ["freeradius", "-f"]

# ENTRYPOINT ["freeradius", "-f"]