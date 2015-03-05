#
# Cookbook Name:: bamboo
# Recipe:: configuration
#
# Copyright 2013, Brian Flad
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

settings = Bamboo.settings(node)

template "#{node['bamboo']['install_path']}/webapp/WEB-INF/classes/bamboo-init.properties" do
  source "bamboo-init.properties.erb"
  owner  node['bamboo']['user']
  mode   "0644"
  notifies :restart, "service[bamboo]", :delayed
end

Chef::Log.info("settings: " + settings.to_s)

template "#{node['bamboo']['home_path']}/bamboo.cfg.xml" do
  source "bamboo.cfg.xml.erb"
  owner  node['bamboo']['user']
  mode   "0644"
  variables :database => settings['database'], :license => node['bamboo']['license']
  #variables :license => node['bamboo']['license']
  notifies :restart, "service[bamboo]", :delayed
end

template "#{node['bamboo']['home_pathf']}/bamboo-mail.cfg.xml" do
  source "bamboo-mail.cfg.xml.erb"
  owner  node['bamboo']['user']
  mode   "0644"
  variables :mail => node['bamboo']['mail']
  notifies :restart, "service[bamboo]", :delayed
end
