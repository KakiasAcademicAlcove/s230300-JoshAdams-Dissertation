directories = %w[
    bin
    config
    data
    jdk
    lib
    logstash-core
    logstash-core-plugin-api
    modules
    pipeline
    tools
    vendor
    x-pack
]

files = %w[
    bin/logstash
    config/jvm.options
    config/log4j2.file.properties
    config/log4j2.properties
    config/logstash.yml
    config/pipelines.yml
    config/startup.options
    pipeline/freeradius_acct_to_kafka.conf
    pipeline/freeradius_acct_to_es.conf
    pipeline/freeradius_auth_accept_to_kafka.conf
    pipeline/freeradius_auth_reject_to_kafka.conf
    pipeline/freeradius_auth_to_es.conf
]

users = %w[
    logstash
]

# Java test?

users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

directories.each do |dir|
    describe directory("/usr/share/logstash/#{dir}") do
      it { should exist }
      its('owner') { should eq 'logstash' }
      its('group') { should eq 'root' }
    end
end

files.each do |file|
    describe file("/usr/share/logstash/#{file}") do
      it { should exist }
      it { should be_owned_by     'logstash' }
      it { should be_grouped_into 'root' }
    end
end
