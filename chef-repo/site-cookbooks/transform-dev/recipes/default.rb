#
# Cookbook Name:: transform-dev
# Recipe:: default
#
# Copyright 2013, Earth Economics
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
#include_recipe 'nodejs'
include_recipe 'nodejs::install_from_package'
include_recipe 'passenger_apache2::mod_rails'
include_recipe 'rvm'
include_recipe 'rvm::user'
include_recipe 'application'


# rvm_gem "pg" do
#   ruby_string "ruby-1.9.3-p374@evt-transform"
#   version "0.14.1"
#   action :install
# end


# application 'transform-dev' do
#   owner 'deploy'
#   group 'deploy'
#   path '/home/deploy/app/transform'

#   private_key = Chef::EncryptedDataBagItem.load_secret("#{node["transform-dev"]["secret_file"]}")
#   app_config = Chef::EncryptedDataBagItem.load("apps", "transform-dev", private_key)
#   deploy_key app_config["deploy_key"]

#   revision 'merged-rest-api'
#   repository 'git@github.com:jgerrish/twic.git'

#   rails do
#     bundler false
#     #bundler true
#     #bundle_command "/home/deploy/.rvm/bin/bundle"

#     database do
#       #adapter "postgresql"
#       rails_env "production"
#       adapter "sqlite3"
#       database "db/transform_production.sqlite3"
#       #username "rails"
#     end

#     # database do
#     #   rails_env "xml_db"
#     #   adapter "sqlite3"
#     #   database "db/xml_db_test.sqlite3"
#     # end
#   end

# end

# web_app "transform" do
#   if !node['cloud'].nil? && node['cloud'].has_key?('public_ipv4')
#     hn = node['cloud']['public_ipv4']
#   else
#     hn = node['hostname']
#   end
#   server_name hn
#   server_aliases [node['fqdn'], node['ipaddress'], node.name]
#   docroot "/home/deploy/app/transform/current/public"
# end
