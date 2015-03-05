#
# Cookbook Name:: apt-if-appropriate
# Recipe:: default
#
# Copyright 2014, Virtual Systems Administrators, Inc.
#
# All rights reserved - Do Not Redistribute
#

# if node ['platform_family'] == "debian"
#	include_recipe "apt"
#end

if platform_family? ("debian")
	include_recipe "apt"
end
