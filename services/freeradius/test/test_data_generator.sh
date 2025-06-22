#!/bin/sh

# Auth-Accept
radtest bob@user.com password123 127.0.0.1 1812 testing123
radtest frank@user.com 123secret 127.0.0.1 1812 testing123
radtest stevie@user.com supersecret1 127.0.0.1 1812 testing123
radtest jake@user.com reallysecret234 127.0.0.1 1812 testing123
radtest josh@user.com blob789 127.0.0.1 1812 testing123

# Auth-Reject
radtest bob@user.com password1234 127.0.0.1 1812 testing123
radtest frank@user.com secret123 127.0.0.1 1812 testing123
radtest stevie@user.com supersecret2 127.0.0.1 1812 testing123
radtest jake@user.com reallysecret345 127.0.0.1 1812 testing123
radtest josh@user.com blob987 127.0.0.1 1812 testing123

# Acct-Start
for file in /etc/freeradius/test/acct-start/acct-start-*.txt; do
    radclient localhost acct testing123 < "$file"
done

# Acct-Interim-Update
for file in /etc/freeradius/test/acct-interim-update/acct-interim-update-*.txt; do
    radclient localhost acct testing123 < "$file"
done

# Acct-Stop
for file in /etc/freeradius/test/acct-stop/acct-stop-*.txt; do
    radclient localhost acct testing123 < "$file"
done
