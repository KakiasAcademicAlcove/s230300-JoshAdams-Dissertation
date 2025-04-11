FROM docker.elastic.co/logstash/logstash:8.17.4
# COPY ${LOGSTASH_CONFIG_DIR}/logstash.yml /usr/share/logstash/config/logstash.yml
# COPY ${LOGSTASH_CONFIG_DIR}/pipelines.yml /usr/share/logstash/config/pipelines.yml
# COPY ${LOGSTASH_PIPELINE_DIR}/freeradius_logs.conf /usr/share/pipeline/freeradius_logs.conf
# RUN chown -R logstash:root ${LOGSTASH_CONFIG_DIR && chown -R logstash:root $LOGSTASH_PIPELINE_DIR

COPY --chown=logstash:root ./config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY --chown=logstash:root ./config/pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY --chown=logstash:root ./pipeline/freeradius_auth_accept.conf /usr/share/logstash/pipeline/freeradius_auth_accept.conf
COPY --chown=logstash:root ./pipeline/freeradius_auth_reject.conf /usr/share/logstash/pipeline/freeradius_auth_reject.conf
