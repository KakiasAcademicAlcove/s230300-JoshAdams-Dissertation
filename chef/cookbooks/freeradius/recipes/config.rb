# Cookbook:: freeradius
# Recipe:: config

freeradius_config_directory =   "#{node["freeradius"]["config_dir"]}"
freeradius_version =            "#{node["freeradius"]["version"]}"
freeradius_directory =          "#{node["freeradius"]["path"]}/#{freeradius_version}"
freeradius_user =               "#{node["freeradius"]["user"]["name"]}"
freeradius_group =              "#{node["freeradius"]["group"]["name"]}"
freeradius_user_id =            "#{node["freeradius"]["user"]["id"]}"
freeradius_group_id =           "#{node["freeradius"]["group"]["id"]}"

# group freeradius_group do
#     gid freeradius_group_id
#     action :create
# end

# user freeradius_user do
#     uid freeradius_user_id
#     gid freeradius_group_id
#     action :create
# end

# directory freeradius_config_directory do
#     action :create
#     recursive true
# end

# directory "#{freeradius_config_directory}/mods-config/files" do
#     action :create
#     recursive true
# end

cookbook_file "#{freeradius_config_directory}/radiusd.conf" do
    source "radiusd.conf"
    # owner freeradius_user
    # group freeradius_group
    # mode "0640"
end

# cookbook_file "#{freeradius_config_directory}/mods-config/files/authorize" do
#     source "users"
#     # owner freeradius_user
#     # group freeradius_group
#     # mode "0640"
# end

cookbook_file "#{freeradius_config_directory}/users" do
    source "users"
    # owner freeradius_user
    # group freeradius_group
    # mode "0640"
end