# Directories that should exist
directories = %w[
    certs
    certs/ca
    data
    kibana
    logs
    module
    modules.d
]

# Files that should exist
files = %w[
    certs/ca/ca.crt
    fields.yml
    filebeat.yml
]

# Check directories exist
directories.each do |dir|
    describe directory("/usr/share/filebeat/#{dir}") do
      it { should exist }
      its('owner') { should eq 'root' }
      its('group') { should eq 'root' }
    end
end

# Check files exist
files.each do |file|
    describe file("/usr/share/filebeat/#{file}") do
      it { should exist }
      it { should be_owned_by     'root' }
      it { should be_grouped_into 'root' }
    end
end
