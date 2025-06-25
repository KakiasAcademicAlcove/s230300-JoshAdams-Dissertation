# Directories that are expected to be owned by "freerad"
freerad_owned_directories = %w[
    certs
    policy.d
    sites-available
    sites-enabled
]

# Directories that are expected to be owned by "root"
root_owned_directories = %w[
    mods-available
    mods-config
    mods-enabled
]

# Files that are expected to be owned by "root"
files = %w[
    clients.conf
    dictionary
    experimental.conf
    hints
    huntgroups
    panic.gdb
    proxy.conf
    radiusd.conf
    templates.conf
    trigger.conf
    users
]

# Users that should exist
users = %w[
    freerad
    root
]

# Check users exist
users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

# Check "freerad" directories exist
freerad_owned_directories.each do |dir|
    describe directory("/etc/freeradius/#{dir}") do
      it { should exist }
      its('owner') { should eq 'freerad' }
      its('group') { should eq 'freerad' }
    end
end

# Check "root" directories exist
root_owned_directories.each do |dir|
    describe directory("/etc/freeradius/#{dir}") do
      it { should exist }
      its('owner') { should eq 'root' }
      its('group') { should eq 'root' }
    end
end

# Check files exist
files.each do |file|
    describe file("/etc/freeradius/#{file}") do
      it { should exist }
      it { should be_owned_by     'root' }
    end
end
