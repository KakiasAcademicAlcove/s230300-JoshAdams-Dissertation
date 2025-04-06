#
# Cookbook:: freeradius
# Recipe:: config
#
# Copyright:: 2025, The Authors, All Rights Reserved.

freeradius_version =        "#{node["freeradius"]["version"]}"
freeradius_directory =      "#{node["freeradius"]["path"]}/#{freeradius_version}"
freeradius_user =           "#{node["freeradius"]["user"]["name"]}"
freeradius_group =          "#{node["freeradius"]["group"]["name"]}"
freeradius_user_id =        "#{node["freeradius"]["user"]["id"]}"
freeradius_group_id =       "#{node["freeradius"]["group"]["id"]}"

# group freeradius_group do
#     gid freeradius_group_id
#     action :create
# end

# user freeradius_user do
#     uid freeradius_user_id
#     gid freeradius_group_id
#     action :create
# end

cookbook_file "radiusd.conf" do
    source "radiusd.conf"
    # owner freeradius_user
    # group freeradius_group
    # mode "0640"
end

cookbook_file "users" do
    source "users"
    # owner freeradius_user
    # group freeradius_group
    # mode "0640"
end