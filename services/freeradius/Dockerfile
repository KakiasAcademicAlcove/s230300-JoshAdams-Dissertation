# 3.2.7 uses Ubuntu 22.04
FROM freeradius/freeradius-server:3.2.7

RUN mkdir -p /var/log/freeradius && chmod -R 755 /var/log/freeradius && chmod 644 /var/log/freeradius/radius.log
# RUN mkdir -p /var/log/freeradius/radacct && chmod -R 755 /var/log/freeradius/radacct
# RUN mkdir -p /var/log/freeradius/radacct && chmod -R 755 /var/log/freeradius/radacct && touch /var/log/freeradius/radacct/detail && chmod 644 /var/log/freeradius/radacct/detail

# FOR TESTING
COPY --chown=freerad:freerad ./test/sample_data/acct/acct-start-1.txt /etc/freeradius
COPY --chown=freerad:freerad ./test/sample_data/acct/acct-stop-1.txt /etc/freeradius
COPY --chown=freerad:freerad ./test/sample_data/acct/acct-start-2.txt /etc/freeradius
COPY --chown=freerad:freerad ./test/sample_data/acct/acct-stop-2.txt /etc/freeradius

COPY --chown=freerad:freerad ./test/sample_data/test_data.sh /etc/freeradius
RUN chmod +x /etc/freeradius/test_data.sh
