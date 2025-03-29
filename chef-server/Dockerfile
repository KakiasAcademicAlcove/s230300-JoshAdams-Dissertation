FROM chef/chef-server:latest

# Reconfigure Chef Server on startup
RUN chef-server-ctl reconfigure && \
    chef-server-ctl user-create admin Admin User admin@example.com 'P@ssw0rd' --filename /etc/chef/admin.pem && \
    chef-server-ctl org-create myorg "My Organization" --association admin --filename /etc/chef/myorg.pem