#
# Cookbook Name:: atlassian-bamboo-agent
# Recipe:: default
#
# Copyright 2013, Earth Economics
#
# All rights reserved - Do Not Redistribute
#

jarfile = node['atlassian-bamboo-agent']['remote_agent_jar']
jarfile_url = node['atlassian-bamboo-agent']['remote_agent_jar_url']
bamboo_home = node['atlassian-bamboo-agent']['bamboo_home']
user = node['atlassian-bamboo-agent']['bamboo_user']
group = node['atlassian-bamboo-agent']['bamboo_group']

execute "wget" do
  cwd "/home/#{user}"
  command "wget #{jarfile_url}"
  creates "/home/#{user}/#{jarfile}"
  action :run
end

remote_file "/home/#{user}/#{jarfile}" do
  user node['atlassian-bamboo-agent']['bamboo_user']
  group node['atlassian-bamboo-agent']['bamboo_group']
  md5sum = node['atlassian-bamboo-agent']['remote_agent_jar_md5']
  source jarfile_url
  mode "0644"
  checksum md5sum
end
