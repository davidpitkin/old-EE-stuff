#
# Cookbook Name:: ee-confluence
# Recipe:: default
#
# Copyright 2013, Earth Economics
#
# All rights reserved - Do Not Redistribute
#

cloud_hostname = "confluence.esvaluation.org"

node.default[:confluence][:apache2][:virtual_host_alias] = cloud_hostname
node.default[:confluence][:apache2][:virtual_host_name] = cloud_hostname

private_key = Chef::EncryptedDataBagItem.load_secret("#{node["ee-confluence"]["secret_file"]}")
app_config = Chef::EncryptedDataBagItem.load("confluence", "confluence", private_key)
Chef::Log.info("app_config" + app_config.inspect)
node.override['mysql']['server_root_password'] = app_config["mysql"]["server_root_password"]

node.override['database']['host'] = "localhost"
node.override['database']['type'] = "mysql"
node.override['database']['password'] = app_config["database"]["password"]
node.override['confluence']['database']['password'] = app_config["database"]["password"]

#include_recipe "confluence"
#include_recipe "confluence::configuration"
include_recipe "confluence::apache2"
