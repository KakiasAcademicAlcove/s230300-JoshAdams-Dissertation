# Directories that should exist
directories = %w[
    bin
    config
    data
    logs
    node
    node_modules
    packages
    plugins
    src
    x-pack
]

# Files that should exist
files = %w[
    config/kibana.yml
    
]

# Users that should exist
users = %w[
    kibana
]

# Check users exist
users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

# Check directories exist
directories.each do |dir|
    describe directory("/usr/share/kibana/#{dir}") do
      it { should exist }
      its('owner') { should eq 'kibana' }
      its('group') { should eq 'root' }
    end
end

# Check files exist
files.each do |file|
    describe file("/usr/share/kibana/#{file}") do
      it { should exist }
      it { should be_owned_by     'kibana' }
      it { should be_grouped_into 'root' }
    end
end
