k#
# Cookbook Name:: evt-word-import-tool
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# The default python recipe includes python, pip and virtualenv
include_recipe "python"
include_recipe "apache2"
include_recipe "apache2::mod_wsgi"
include_recipe "logrotate"
include_recipe "application"

venv_dir = "/srv/evt-word-import-tool"

directory venv_dir do
  owner "deploy"
  group "deploy"
  recursive true
  mode 0775
end

python_virtualenv venv_dir do
  interpreter "python2.7"
  owner "deploy"
  group "deploy"
  action :create
end

repo_path = "/srv/evt-word-import-tool/ImportTool/usr/local/lib/eartheconomics"

python_pip "django" do
  version "1.4.5"
  virtualenv venv_dir
  action :install
end

# application "evt-word-import-tool" do
#   path "/srv/evt-word-import-tool"
#   owner "deploy"
#   group "deploy"

#   private_key = Chef::EncryptedDataBagItem.load_secret("#{node["evt-word-import-tool"]["secret_file"]}")
#   app_config = Chef::EncryptedDataBagItem.load("apps", "evt-word-import-tool", private_key)
#   repository "git@github.com:eartheconomics/Tools.git"
#   revision "master"
#   deploy_key app_config["deploy_key"]

  # django do
  #   database do
  #     database "evt-word-import-tool"
  #     engine "django.db.backends.sqlite3"
  #   end
  # end

#   web_app "my_site" do
#     if !node['cloud'].nil? && node['cloud'].has_key?('public_ipv4')
#       hn = node['cloud']['public_ipv4']
#     else
#       hn = node['hostname']
#     end
#     server_name hn
#     server_aliases [node['fqdn'], node['ipaddress'], node.name]
#     docroot "/srv/evt-word-import-tool/ImportTool/usr/local/lib/eartheconomics"

#   end

# end


# remote_directory venv_dir do
#   source repo_path
#   owner "deploy"
#   group "deploy"
# end



# Commented out to allow easier development on the system for Luke
# TODO: Re-enable when done
#
# web_app "evt_word_import_tool" do
#   if !node['cloud'].nil? && node['cloud'].has_key?('public_ipv4')
#     hn = node['cloud']['public_ipv4']
#   else
#     hn = node['hostname']
#   end
#   server_name hn
#   server_aliases [node['fqdn'], node['ipaddress'], node.name]
#   docroot "/srv/evt-word-import-tool/eartheconomics"
#   envroot "/srv/evt-word-import-tool"

# end
