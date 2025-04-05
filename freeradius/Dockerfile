# 3.2.7 uses Ubuntu 22.04
FROM freeradius/freeradius-server:3.2.7

# Install Cinc
COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

RUN mkdir -p /var/log/freeradius && chmod -R 754 /var/log/freeradius

# Verify install
RUN chef-client --version

# Copy over Cinc files
COPY chef/ opt/cinc/

# FreeRADIUS runs in foreground as main PID
CMD ["freeradius", "-f"]
