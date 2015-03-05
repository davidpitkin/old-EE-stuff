#
# Cookbook Name:: maldetect
# Recipe:: default
#
# Copyright 2013, Virtual Systems Administrators, Inc.
#
# All rights reserved - Do Not Redistribute
#
# cookbooks/maldetect/recipes/default.rb
#
# Cookbook Name:: maldetect
# Recipe:: default
#
# Copyright 2013, Virtual Systems Administrators, LLC
#
# All rights reserved - Do Not Redistribute
#
 
maldet_version = node["maldetect"]["version"]
# cd /tmp
# wget http://www.rfxn.com/downloads/maldetect-current.tar.gz 
remote_file "#{Chef::Config[:file_cache_path]}/maldetect-current.tar.gz" do
  action :create
  source "http://www.rfxn.com/downloads/maldetect-current.tar.gz"
  checksum node["maldetect"]["checksum"]
  owner "root"
  group "root"
end
 
# tar xfz maldetect-current.tar.gz
execute "unpack maldetect" do
  not_if {::File.directory?("#{Chef::Config[:file_cache_path]}/maldetect-#{maldet_version}")}
  cwd Chef::Config[:file_cache_path]
  command "tar xfz maldetect-current.tar.gz"
end
 
# cd maldetect-1.4.1/
# ./install.sh
execute "install maldetect" do
  cwd "#{Chef::Config[:file_cache_path]}/maldetect-#{maldet_version}"
  command "./install.sh"
  not_if {::File.directory?("/usr/local/maldetect")} || not_if {::File.read("/usr/local/maldetect/VERSION").strip == maldet_version}
end
 
# -> maldet --update
execute "update maldet" do
  command "maldet --update"
  returns [0,1]
  # TODO:  Should this be run every time chef-client is executed?
  #        Probably best to sort out a guard
end
 
# TODO:  Do you really need this?  It seems that the standard maldet 
#        install drops a cron into /etc/cron.daily/maldet
 
# -> add custom maldet.sh script with appropriate permissions to /root 
directory "/root" do
  owner "root"
  group "root"
end
 
template "/root/maldet.sh" do
  source "maldet.sh.erb"
  owner "root"
  group "root"
  mode "0755"
end
 
# -> add the following to root's crontab
# 30 01 * * * sh /root/maldet.sh
cron "run maldet" do
  minute "30"
  hour "01"
  command "sh /root/maldet.sh"
end
 
# This shouldn't be necessary:
# -> /etc/init.d/crond|service cron restart
