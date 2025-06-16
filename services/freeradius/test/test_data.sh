#!/bin/sh

# Auth
radtest testuser password 127.0.0.1 1812 testing123
radtest testuser1 password 127.0.0.1 1812 testing123

# Acct
cd /etc/freeradius/test && radclient localhost acct testing123 < acct-start-1.txt
cd /etc/freeradius/test && radclient localhost acct testing123 < acct-start-2.txt
cd /etc/freeradius/test && radclient localhost acct testing123 < acct-stop-1.txt
cd /etc/freeradius/test && radclient localhost acct testing123 < acct-stop-2.txt
