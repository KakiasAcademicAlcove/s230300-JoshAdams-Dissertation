# 3.2.7 uses Ubuntu 22.04
FROM freeradius/freeradius-server:3.2.7

RUN mkdir -p /var/log/freeradius && chmod -R 755 /var/log/freeradius && chmod 644 /var/log/freeradius/radius.log
# RUN mkdir -p /var/log/freeradius/radacct && chmod 755 /var/log/freeradius/radacct && touch /var/log/freeradius/radacct/detail && chmod 644 /var/log/freeradius/radacct/detail
COPY --chown=root:root ./sample_data/acct-start.txt /etc/freeradius
COPY --chown=root:root ./sample_data/acct-stop.txt /etc/freeradius
