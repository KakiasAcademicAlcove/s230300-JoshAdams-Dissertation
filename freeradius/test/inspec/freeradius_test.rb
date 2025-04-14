freerad_owned_directories = %w[
    certs
    policy.d
    sites-available
    sites-enabled
]

root_owned_directories = %w[
    mods-available
    mods-config
    mods-enabled
]

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

users = %w[
    freerad
]

users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

freerad_owned_directories.each do |dir|
    describe directory("/etc/freeradius/#{dir}") do
      it { should exist }
      its('owner') { should eq 'freerad' }
      its('group') { should eq 'freerad' }
    end
end

root_owned_directories.each do |dir|
    describe directory("/etc/freeradius/#{dir}") do
      it { should exist }
      its('owner') { should eq 'root' }
      its('group') { should eq 'root' }
    end
end

files.each do |file|
    describe file("/etc/freeradius/#{file}") do
      it { should exist }
      it { should be_owned_by     'root' }
    end
end
