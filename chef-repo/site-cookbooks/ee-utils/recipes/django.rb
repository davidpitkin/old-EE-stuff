#
# Cookbook Name:: ee-utils
# Recipe:: django
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Loop through all sudo users and add them to the system
# Normally we would just add the sysadmin group to their
# data bag item.  But that makes them an admin on every server
# This way we can control it per-server

users_manage "eng" do
  group_id 2400
  action [ :remove, :create ]
end
