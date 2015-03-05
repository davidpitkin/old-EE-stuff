#
# Cookbook Name:: rkhunter
# Recipe:: default
#
# Copyright 2013, Virtual Systems Administrators, Inc.
#
# All rights reserved - Do Not Redistribute
#


# Preamble
rkhunter_version = node["rkhunter"]["version"]

# cd /tmp
# wget http://ncu.dl.sourceforge.net/project/rkhunter/rkhunter/1.4.0/rkhunter-1.4.0.tar.gz
remote_file "#{Chef::Config[:file_cache_path]}/rkhunter-1.4.0.tar.gz" do	
  action :create
  source "http://ncu.dl.sourceforge.net/project/rkhunter/rkhunter/1.4.0/rkhunter-1.4.0.tar.gz"
  checksum node["rkhunter"]["checksum"]
  owner "root"
  group "root"
end	

# tar xfz ...
execute "unpack rkhunter" do
  cwd Chef::Config[:file_cache_path]
  command "tar xfz rkhunter-1.4.0.tar.gz"
  not_if {::File.directory?("#{Chef::Config[:file_cache_path]}/rkhunter-#{rkhunter_version}")}
end

# cd rkhunter…
# ./installer.sh --install
execute "install rkhunter" do
  cwd "#{Chef::Config[:file_cache_path]}/rkhunter-#{rkhunter_version}"
  command "./installer.sh --install"
  not_if {::File.exists?('/usr/local/bin/rkhunter')}
  # command "/usr/local/bin/rkhunter --versioncheck"
  # not_if ... from above && not_if { something with grep|cut|sed for 'This version' and 'Latest version'}
end

# rkhunter --update
# execute "update rkhunter" do
  # we'll let cron take care of this...
  # command "/usr/local/bin/rkhunter --update"
# end

# rkhunter --check
# execute "run rkhunter check" do
  # we'll let cron take care of this...
  # command "/usr/local/bin/rkhunter --check"
# end

# Daily update and check for rootkithunter (run "which rkhunter, to make sure you get the path right):
# 40 2 * * * /usr/local/bin/rkhunter --update
# 00 2 * * * /usr/local/bin/rkhunter --crontab
cron "update rkhunter" do
  minute "40"
  hour "2"
  command "/usr/local/bin/rkhunter --update"
end
cron "run rkhunter check" do
  minute "00"
  hour "2"
  command "/usr/local/bin/rkhunter --check"
end
