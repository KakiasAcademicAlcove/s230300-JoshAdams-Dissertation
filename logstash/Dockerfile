# Uses Ubuntu 20.04
FROM logstash:8.17.4

# COPY binaries/logstash-8.17.4-amd64.deb tmp/logstash.deb
# RUN dpkg -i tmp/logstash.deb
# RUN apt-get install -f -y
# RUN rm -f /tmp/logstash.deb

USER root

COPY binaries/cinc_18.6.2-1_amd64.deb tmp/cinc.deb
RUN dpkg -i tmp/cinc.deb
RUN apt-get install -f -y
RUN rm -f /tmp/cinc.deb

RUN chef-client --version



# Copy over Cinc files
COPY chef/ opt/cinc/

USER logstash

# Copy initial files for Logstash service start-up
# COPY logstash.yml /usr/share/logstash/config/logstash.yml
# COPY pipelines.yml /usr/share/logstash/config/pipelines.yml
# COPY freeradius_logs.conf /usr/share/logstash/pipeline/freeradius_logs.conf

# Environment variables
# ENV LOGSTASH_JAVA_OPTS="-Xmx1g -Xms1g"
# ENV XPACK_MONITORING_ENABLED="false"

# Run Logstash (in the foreground -f)
CMD ["/usr/share/logstash/bin/logstash", "-f"]
