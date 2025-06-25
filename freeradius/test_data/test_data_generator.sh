#!/bin/sh

# This script uses "radtest" command for simulating Auth requests
# and "radclient" command for simulating Acct requests to 
# generate sample data

# Simulate Auth requests that result in "Auth-Accept"
radtest bob@user.com password123 127.0.0.1 1812 testing123
radtest frank@user.com 123secret 127.0.0.1 1812 testing123
radtest stevie@user.com supersecret1 127.0.0.1 1812 testing123
radtest jake@user.com reallysecret234 127.0.0.1 1812 testing123
radtest josh@user.com blob789 127.0.0.1 1812 testing123

# Simulate Auth requests that result in "Auth-Reject"
radtest bob@user.com password1234 127.0.0.1 1812 testing123
radtest frank@user.com secret123 127.0.0.1 1812 testing123
radtest stevie@user.com supersecret2 127.0.0.1 1812 testing123
radtest jake@user.com reallysecret345 127.0.0.1 1812 testing123
radtest josh@user.com blob987 127.0.0.1 1812 testing123

# Simulate "Acct-Start" requests
for file in /etc/freeradius/test_data/acct-start/acct-start-*.txt; do
    radclient localhost acct testing123 < "$file"
done

# Simulate "Acct-Interim-Update" requests
for file in /etc/freeradius/test_data/acct-interim-update/acct-interim-update-*.txt; do
    radclient localhost acct testing123 < "$file"
done

# Simuate "Acct-Stop" requests
for file in /etc/freeradius/test_data/acct-stop/acct-stop-*.txt; do
    radclient localhost acct testing123 < "$file"
done
