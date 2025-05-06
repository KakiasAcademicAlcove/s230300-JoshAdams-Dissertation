#!/bin/bash

# Auth

echo 'Mon Apr 21 10:17:43 2025 : Auth: (0) Login OK: [testuser] (from client localhost port 1812)' >> /var/log/freeradius/radius.log &&
echo 'Mon Apr 21 10:18:10 2025 : Auth: (1) Login incorrect (rlm_pap: CLEAR TEXT password check failed): [baduser] (from client localhost port 1812)' >> /var/log/freeradius/radius.log &&

# Acct

mkdir -p /var/log/freeradius/radacct
chown freerad:freerad /var/log/freeradius/radacct
chmod 755 radacct

touch detail
chown freerad:freerad /var/log/freeradius/radacct/detail
chmod 744 detail

cat <<EOF >> /var/log/freeradius/radacct/detail
Mon May  5 19:40:42 2025
        User-Name = "bob"
        Acct-Status-Type = Start
        NAS-IP-Address = 127.0.0.1
        Acct-Session-Id = "session123"
        Framed-IP-Address = 192.168.0.10
        NAS-Port = 0
        NAS-Port-Type = Ethernet
        Calling-Station-Id = "00-14-22-01-23-45"
        Called-Station-Id = "00-14-22-67-89-ab"
        Event-Timestamp = "May  5 2025 19:40:42 UTC"
        Acct-Unique-Session-Id = "1e48f981a04ab18315d083d6e5e8e47e"
        Timestamp = 1746474042

EOF

cat <<EOF >> /var/log/freeradius/radacct/detail
Mon May  5 19:45:08 2025
        User-Name = "bob"
        Acct-Status-Type = Stop
        NAS-IP-Address = 127.0.0.1
        Acct-Session-Id = "session123"
        Framed-IP-Address = 192.168.0.10
        NAS-Port = 0
        NAS-Port-Type = Ethernet
        Calling-Station-Id = "00-14-22-01-23-45"
        Called-Station-Id = "00-14-22-67-89-ab"
        Event-Timestamp = "May  5 2025 19:45:08 UTC"
        Acct-Unique-Session-Id = "1e48f981a04ab18315d083d6e5e8e47e"
        Timestamp = 1746474308

EOF

sleep 5