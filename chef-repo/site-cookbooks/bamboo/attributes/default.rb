#
# Cookbook Name:: bamboo
# Attributes:: bamboo
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

default['bamboo']['home_path']      = "/var/atlassian/application-data/bamboo"
default['bamboo']['install_path']   = "/opt/atlassian/bamboo"
default['bamboo']['install_type']   = "standalone"
default['bamboo']['url_base']       = "http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo"
default['bamboo']['user']           = "bamboo"
default['bamboo']['version']        = "4.4.5"

if node['kernel']['machine'] == "x86_64"
  default['bamboo']['arch'] = "x64"
else
  default['bamboo']['arch'] = "x32"
end

if node['platform_family'] != "windows"
  case node['bamboo']['install_type']
  when "standalone"
    default['bamboo']['url']      = "#{node['bamboo']['url_base']}-#{node['bamboo']['version']}.tar.gz"
    default['bamboo']['checksum'] = case node['bamboo']['version']
    when "4.4.5"; "123ba9227d84b1a5f6e89d82e288b774e910f2b7ec437cf6c207064b1c2a208d"
    end
  when "war"
    default['bamboo']['url']      = "#{node['bamboo']['url_base']}-#{node['bamboo']['version']}.war"
    default['bamboo']['checksum'] = case node['bamboo']['version']
    when "4.4.5"; "4c7d16277a78a1de9e4fed5ef1330e23a6249c1e073c2a225199d6016d1e3f9f"
    end
  end
end

default['bamboo']['apache2']['access_log']         = ""
default['bamboo']['apache2']['error_log']          = ""
default['bamboo']['apache2']['port']               = 80
default['bamboo']['apache2']['virtual_host_alias'] = node['fqdn']
default['bamboo']['apache2']['virtual_host_name']  = node['hostname']

default['bamboo']['apache2']['ssl']['access_log']       = ""
default['bamboo']['apache2']['ssl']['chain_file']       = ""
default['bamboo']['apache2']['ssl']['error_log']        = ""
default['bamboo']['apache2']['ssl']['port']             = 443

case node['platform_family']
when 'rhel'
  default['bamboo']['apache2']['ssl']['certificate_file'] = "/etc/pki/tls/certs/localhost.crt"
  default['bamboo']['apache2']['ssl']['key_file']         = "/etc/pki/tls/private/localhost.key"
else
  default['bamboo']['apache2']['ssl']['certificate_file'] = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
  default['bamboo']['apache2']['ssl']['key_file']         = "/etc/ssl/private/ssl-cert-snakeoil.key"
end

default['bamboo']['database']['host']     = "localhost"
default['bamboo']['database']['name']     = "bamboo"
default['bamboo']['database']['password'] = "changeit"
default['bamboo']['database']['port']     = 3306
default['bamboo']['database']['type']     = "mysql"
default['bamboo']['database']['user']     = "bamboo"

default['bamboo']['jvm']['minimum_memory']  = "256m"
default['bamboo']['jvm']['maximum_memory']  = "512m"
default['bamboo']['jvm']['maximum_permgen'] = "256m"
default['bamboo']['jvm']['java_opts']       = ""

default['bamboo']['tomcat']['keyAlias']     = "tomcat"
default['bamboo']['tomcat']['keystoreFile'] = "#{node['bamboo']['home_path']}/.keystore"
default['bamboo']['tomcat']['keystorePass'] = "changeit"
default['bamboo']['tomcat']['port']         = "8085"
default['bamboo']['tomcat']['ssl_port']     = "8443"

default['bamboo']['mail']['name']           = "Your Org Name"
default['bamboo']['mail']['username']       = "mailserverusername"
default['bamboo']['mail']['password']       = "mailserverpassword"
default['bamboo']['mail']['defaultFrom']    = "admin@bamboo.test.com"
default['bamboo']['mail']['prefix']         = "[Bamboo]"
default['bamboo']['mail']['hostname']       = "mail.server.test.com"
default['bamboo']['mail']['sessionServer']  = "false"
default['bamboo']['mail']['port']           = "25"
default['bamboo']['mail']['tlsRequired']    = "true"
