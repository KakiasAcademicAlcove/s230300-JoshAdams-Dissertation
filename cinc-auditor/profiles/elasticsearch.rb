elasticsearch_directories = %w[
    bin
    config
    data
    data/_state
    data/indices
    data/snapshot_cache
    logs
    plugins
]

root_directories = %w[
    config/certs
    jdk
    lib
    modules
]

files = %w[
    config/elasticsearch.yml
    config/jvm.options
    config/log4j2.file.properties
    config/log4j2.properties
    config/role_mapping.yml
    config/roles.yml
    config/users
    config/users_roles
]

users = %w[
    elasticsearch
]

users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

elasticsearch_directories.each do |dir|
    describe directory("/usr/share/elasticsearch/#{dir}") do
      it { should exist }
      its('owner') { should eq 'elasticsearch' }
      its('group') { should eq 'root' }
    end
end

root_directories.each do |dir|
    describe directory("/usr/share/elasticsearch/#{dir}") do
      it { should exist }
      its('owner') { should eq 'root' }
      its('group') { should eq 'root' }
    end
end

files.each do |file|
    describe file("/usr/share/elasticsearch/#{file}") do
      it { should exist }
      it { should be_owned_by     'root' }
    end
end
