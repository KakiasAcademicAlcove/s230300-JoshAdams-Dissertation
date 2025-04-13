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

files = %w[
    config/kibana.yml
    
]

users = %w[
    kibana
]

users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

directories.each do |dir|
    describe directory("/usr/share/kibana/#{dir}") do
      it { should exist }
      its('owner') { should eq 'kibana' }
      its('group') { should eq 'root' }
    end
end

files.each do |file|
    describe file("/usr/share/kibana/#{file}") do
      it { should exist }
      it { should be_owned_by     'kibana' }
      it { should be_grouped_into 'kibana' }
    end
end
