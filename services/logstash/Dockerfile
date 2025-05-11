FROM docker.elastic.co/logstash/logstash:8.17.4

# Config files
COPY --chown=logstash:root ./config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY --chown=logstash:root ./config/pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY --chown=logstash:root ./config/jvm.options /usr/share/logstash/config/jvm.options
COPY --chown=logstash:root ./config/log4j2.file.properties /usr/share/logstash/config/log4j2.file.properties
COPY --chown=logstash:root ./config/log4j2.properties /usr/share/logstash/config/log4j2.properties
COPY --chown=logstash:root ./config/startup.options /usr/share/logstash/config/startup.options

# Pipeline configurations
COPY --chown=logstash:root ./pipeline/ssl/freeradius_auth_accept_to_kafka.conf /usr/share/logstash/pipeline/freeradius_auth_accept_to_kafka.conf
COPY --chown=logstash:root ./pipeline/ssl/freeradius_auth_reject_to_kafka.conf /usr/share/logstash/pipeline/freeradius_auth_reject_to_kafka.conf
COPY --chown=logstash:root ./pipeline/ssl/freeradius_auth_to_es.conf /usr/share/logstash/pipeline/freeradius_auth_to_es.conf
COPY --chown=logstash:root ./pipeline/ssl/freeradius_acct_to_kafka.conf /usr/share/logstash/pipeline/freeradius_acct_to_kafka.conf
COPY --chown=logstash:root ./pipeline/ssl/freeradius_acct_to_es.conf /usr/share/logstash/pipeline/freeradius_acct_to_es.conf

# Certs