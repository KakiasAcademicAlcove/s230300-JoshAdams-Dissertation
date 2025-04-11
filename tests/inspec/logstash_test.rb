describe file("/usr/share/logstash/pipeline/radius_logs.conf") do
    it { should exist}
    its('owner') { should eq 'logstash' }
    its('group') { should eq 'root' }
    its('mode') { should eq '0644' }
end