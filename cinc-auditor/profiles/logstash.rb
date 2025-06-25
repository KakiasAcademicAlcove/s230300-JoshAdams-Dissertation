# Directories that should exist
directories = %w[
    bin
    certs
    certs/kafka
    certs/ca
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

# Files that should exist
files = %w[
    bin/logstash
    certs/kafka/logstash.truststore.jks
    certs/ca/ca.crt
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

# Check directories exist
directories.each do |dir|
    describe directory("/usr/share/logstash/#{dir}") do
      it { should exist }
    end
end

# Check files exist
files.each do |file|
    describe file("/usr/share/logstash/#{file}") do
      it { should exist }
    end
end
