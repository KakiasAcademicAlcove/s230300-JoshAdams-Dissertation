directories = %w[
    bin
    config
    libs
    licenses
    logs
]

files = %w[
    bin/kafka-acls.sh
    bin/kafka-broker-api-versions.sh
    bin/kafka-client-metrics.sh
    bin/kafka-cluster.sh
    bin/kafka-configs.sh
    bin/kafka-console-consumer.sh
    bin/kafka-console-producer.sh
    bin/kafka-console-share-consumer.sh
    bin/kafka-consumer-groups.sh
    bin/kafka-consumer-perf-test.sh
    bin/kafka-delegation-tokens.sh
    bin/kafka-delete-records.sh
    bin/kafka-dump-log.sh
    bin/kafka-e2e-latency.sh
    bin/kafka-features.sh
    bin/kafka-get-offsets.sh
    bin/kafka-groups.sh
    bin/kafka-jmx.sh
    bin/kafka-leader-election.sh
    bin/kafka-log-dirs.sh
    bin/kafka-metadata-quorum.sh
    bin/kafka-metadata-shell.sh
    bin/kafka-producer-perf-test.sh
    bin/kafka-reassign-partitions.sh
    bin/kafka-replica-verification.sh
    bin/kafka-run-class.sh
    bin/kafka-server-start.sh
    bin/kafka-server-stop.sh
    bin/kafka-storage.sh
    bin/kafka-streams-application-reset.sh
    bin/kafka-topics.sh
    bin/kafka-transactions.sh
    bin/kafka-verifiable-consumer.sh
    bin/kafka-verifiable-producer.sh
    bin/trogdor.sh
    config/broker.properties
    config/connect-console-sink.properties
    config/connect-console-source.properties
    config/connect-distributed.properties
    config/connect-file-sink.properties
    config/connect-file-source.properties
    config/connect-log4j2.yaml
    config/connect-mirror-maker.properties
    config/connect-standalone.properties
    config/consumer.properties
    config/controller.properties
    config/log4j2.yaml
    config/producer.properties
    config/server.properties
    config/tools-log4j2.yaml
    config/trogdor.conf
]

users = %w[
    appuser
]

# Java test?

users.each do |user|
    describe user("#{user}") do
        it { should exist }
    end
end

directories.each do |dir|
    describe directory("/opt/kafka/#{dir}") do
      it { should exist }
      its('owner') { should eq 'appuser' }
      its('group') { should eq 'appuser' }
    end
end

files.each do |file|
    describe file("/opt/kafka/#{file}") do
      it { should exist }
      it { should be_owned_by     'appuser' }
      it { should be_grouped_into 'appuser' }
    end
end
