# 3.2.7 uses Ubuntu 22.04
FROM freeradius/freeradius-server:3.2.7

RUN mkdir -p /var/log/freeradius && chmod -R 755 /var/log/freeradius && chmod 644 /var/log/freeradius/radius.log

# FOR TESTING
COPY --chown=freerad:freerad ./test/acct/acct-start-1.txt /etc/freeradius
COPY --chown=freerad:freerad ./test/acct/acct-stop-1.txt /etc/freeradius
COPY --chown=freerad:freerad ./test/acct/acct-start-2.txt /etc/freeradius
COPY --chown=freerad:freerad ./test/acct/acct-stop-2.txt /etc/freeradius

COPY --chown=freerad:freerad ./test/test_data.sh /etc/freeradius
RUN chmod +x /etc/freeradius/test_data.sh
