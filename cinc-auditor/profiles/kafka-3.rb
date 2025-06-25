# Directories that should exist
directories = %w[
    /opt/kafka/bin
    /opt/kafka/config
    /opt/kafka/libs
    /opt/kafka/licenses
    /opt/kafka/logs
    /etc/kafka/secrets
]

# Files that should exist
files = %w[
    /opt/kafka/bin/kafka-acls.sh
    /opt/kafka/bin/kafka-broker-api-versions.sh
    /opt/kafka/bin/kafka-client-metrics.sh
    /opt/kafka/bin/kafka-cluster.sh
    /opt/kafka/bin/kafka-configs.sh
    /opt/kafka/bin/kafka-console-consumer.sh
    /opt/kafka/bin/kafka-console-producer.sh
    /opt/kafka/bin/kafka-console-share-consumer.sh
    /opt/kafka/bin/kafka-consumer-groups.sh
    /opt/kafka/bin/kafka-consumer-perf-test.sh
    /opt/kafka/bin/kafka-delegation-tokens.sh
    /opt/kafka/bin/kafka-delete-records.sh
    /opt/kafka/bin/kafka-dump-log.sh
    /opt/kafka/bin/kafka-e2e-latency.sh
    /opt/kafka/bin/kafka-features.sh
    /opt/kafka/bin/kafka-get-offsets.sh
    /opt/kafka/bin/kafka-groups.sh
    /opt/kafka/bin/kafka-jmx.sh
    /opt/kafka/bin/kafka-leader-election.sh
    /opt/kafka/bin/kafka-log-dirs.sh
    /opt/kafka/bin/kafka-metadata-quorum.sh
    /opt/kafka/bin/kafka-metadata-shell.sh
    /opt/kafka/bin/kafka-producer-perf-test.sh
    /opt/kafka/bin/kafka-reassign-partitions.sh
    /opt/kafka/bin/kafka-replica-verification.sh
    /opt/kafka/bin/kafka-run-class.sh
    /opt/kafka/bin/kafka-server-start.sh
    /opt/kafka/bin/kafka-server-stop.sh
    /opt/kafka/bin/kafka-storage.sh
    /opt/kafka/bin/kafka-streams-application-reset.sh
    /opt/kafka/bin/kafka-topics.sh
    /opt/kafka/bin/kafka-transactions.sh
    /opt/kafka/bin/kafka-verifiable-consumer.sh
    /opt/kafka/bin/kafka-verifiable-producer.sh
    /opt/kafka/bin/trogdor.sh
    /opt/kafka/config/broker.properties
    /opt/kafka/config/connect-console-sink.properties
    /opt/kafka/config/connect-console-source.properties
    /opt/kafka/config/connect-distributed.properties
    /opt/kafka/config/connect-file-sink.properties
    /opt/kafka/config/connect-file-source.properties
    /opt/kafka/config/connect-log4j2.yaml
    /opt/kafka/config/connect-mirror-maker.properties
    /opt/kafka/config/connect-standalone.properties
    /opt/kafka/config/consumer.properties
    /opt/kafka/config/controller.properties
    /opt/kafka/config/log4j2.yaml
    /opt/kafka/config/producer.properties
    /opt/kafka/config/server.properties
    /opt/kafka/config/tools-log4j2.yaml
    /opt/kafka/config/trogdor.conf
    /etc/kafka/secrets/kafka-3.keystore.jks
    /etc/kafka/secrets/kafka-3.truststore.jks
    /etc/kafka/secrets/kafka-3-ssl.properties
]

# Users that should exist
users = %w[
    appuser
]

# Check users exist
users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

# Check directories exist
directories.each do |dir|
    describe directory("#{dir}") do
      it { should exist }
      its('owner') { should eq 'appuser' }
      its('group') { should eq 'appuser' }
    end
end

# Check files exist
files.each do |file|
    describe file("#{file}") do
      it { should exist }
      it { should be_owned_by     'appuser' }
      it { should be_grouped_into 'appuser' }
    end
end
