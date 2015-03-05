#
# Cookbook Name:: ee-jira
# Recipe:: default
#
# Chef recipe to install and manage an Atlassian Jira instance
#
# Copyright 2013, Earth Economics
#
# All rights reserved - Do Not Redistribute
#
include_recipe "AFW"

cloud_hostname = "jira.esvaluation.org"

users_manage "ee-admin" do
  group_id 2400
  action [ :remove, :create ]
end

node.default[:jira][:apache2][:virtual_host_alias] = cloud_hostname
node.default[:jira][:apache2][:virtual_host_name] = cloud_hostname

#node.default[:jira][:secret_file]
private_key = Chef::EncryptedDataBagItem.load_secret("#{node["ee-jira"]["secret_file"]}")
app_config = Chef::EncryptedDataBagItem.load("jira", "jira", private_key)
node.override['mysql']['server_root_password'] = app_config["mysql"]["server_root_password"]

node.override['database']['host'] = "localhost"
node.override['database']['type'] = "mysql"
node.override['database']['password'] = app_config["database"]["password"]
node.override['jira']['database']['password'] = app_config["database"]["password"]

settings = Jira.settings(node)

#include_recipe "jira"
#include_recipe "jira::tomcat_configuration"
#include_recipe "jira::configuration"
include_recipe "jira::apache2"
