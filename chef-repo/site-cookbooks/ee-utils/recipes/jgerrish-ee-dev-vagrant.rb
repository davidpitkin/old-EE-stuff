# The default python recipe includes python, pip and virtualenv
include_recipe 'apt'
include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe "apache2::mod_wsgi"
include_recipe "python"
include_recipe "rvm"
include_recipe "rvm::user"
include_recipe "logrotate"
include_recipe "application"
include_recipe 'nodejs::install_from_package'
#include_recipe "transform-dev::default"

users_manage "eng" do
  group_id 2400
  action [ :remove, :create ]
end

#node['users'].each do |u|
u = "jgerrish"

venv_dir = "/home/" + u + "/" + node["ee-dev-vagrant"]["venv_dir"]

directory venv_dir do
  owner u
  group u
  recursive true
  mode 0775
end

rvm_ruby "ruby-1.9.3-p392" do
  action :install
  user u
end

rvm_gemset "ruby-1.9.3-p392@evt-transform" do
  action :create
  user u
end

python_virtualenv venv_dir do
  interpreter "python2.7"
  owner u
  group u
  action :create
end

python_pip "django" do
  version "1.5.1"
  virtualenv venv_dir
  action :install
end

#end
