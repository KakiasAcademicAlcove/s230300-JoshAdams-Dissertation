#
# Cookbook:: freeradius
# Recipe:: config
#
# Copyright:: 2025, The Authors, All Rights Reserved.

freeradius_version =        "#{node["freeradius"]["version"]}"
freeradius_directory =      "#{node["freeradius"]["path"]}/#{freeradius_version}"
freeradius_user =           "#{node["freeradius"]["user"]}"
freeradius_group =           "#{node["freeradius"]["group"]}"

cookbook_file "#{freeradius_directory}/radiusd.conf" do
    source "radiusd.conf"
    owner freeradius_user
    group freeradius_group
    mode "0640"
end

cookbook_file "#{freeradius_directory}/users" do
    source "radiusd.conf"
    owner freeradius_user
    group freeradius_group
    mode "0640"
end

execute "restart freeradius" do
    command "kill -HUP $(pidof freeradius)"
    action :run
end