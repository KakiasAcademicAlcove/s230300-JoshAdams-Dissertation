directories = %w[
    data
    kibana
    logs
    module
    modules.d
]

files = %w[
    fields.yml
    metricbeat.yml
]

directories.each do |dir|
    describe directory("/usr/share/metricbeat/#{dir}") do
      it { should exist }
      its('owner') { should eq 'root' }
      its('group') { should eq 'root' }
    end
end

files.each do |file|
    describe file("/usr/share/metricbeat/#{file}") do
      it { should exist }
      it { should be_owned_by     'root' }
      it { should be_grouped_into 'root' }
    end
end
