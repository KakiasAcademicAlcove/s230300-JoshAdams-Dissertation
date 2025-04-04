# 3.2.7 uses Ubuntu 22.04
FROM freeradius/freeradius-server:3.2.7

# Update container
# RUN apt-get update && apt-get upgrade -y && apt-get install -y curl

# Install FreeRADIUS
# RUN apt-get install -y freeradius freeradius-ldap freeradius-mysql

# Install Cinc
COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

# Verify install
RUN chef-client --version

# Copy over Cinc files
COPY chef/ opt/cinc/

# FreeRADIUS runs in foreground as main PID
CMD ["freeradius", "-f"]
