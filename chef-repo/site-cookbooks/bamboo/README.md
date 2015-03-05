# chef-bamboo [![Build Status](https://secure.travis-ci.org/bflad/chef-bamboo.png?branch=master)](http://travis-ci.org/bflad/chef-bamboo)

## Description

Installs/Configures Atlassian Bamboo server. Please see [COMPATIBILITY.md](COMPATIBILITY.md) for more information about Bamboo releases that are tested and supported by this cookbook and its versions.

## Requirements

### Platforms

* CentOS 6
* RedHat 6
* Ubuntu 12.04

### Databases

* MySQL
* Postgres

### Cookbooks

Required [Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [apache2](https://github.com/opscode-cookbooks/apache2) (if using Apache 2 proxy)
* [database](https://github.com/opscode-cookbooks/database)
* [mysql](https://github.com/opscode-cookbooks/mysql) (if using MySQL database)
* [postgresql](https://github.com/opscode-cookbooks/postgresql) (if using Postgres database)

Required Third-Party Cookbooks

* [mysql_connector](https://github.com/bflad/chef-mysql_connector) (if using MySQL database)

Suggested [Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [java](https://github.com/opscode-cookbooks/java)

### JDK/JRE

The Atlassian Bamboo Linux installer will automatically configure a bundled JRE. If you wish to use your own JDK/JRE, with say the `java` cookbook, then as of this writing it must be Oracle JDK 7 ([Supported Platforms](https://bamboo.atlassian.com/display/DOC/Supported+Platforms))

Necessary configuration with `java` cookbook:
* `node['java']['install_flavor'] = "oracle"`
* `node['java']['jdk_version'] = "7"`
* `node['java']['oracle']['accept_oracle_download_terms'] = true`
* `recipe[java]`

## Attributes

These attributes are under the `node['bamboo']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
arch | architecture for Bamboo installer - "x64" or "x32" | String | auto-detected (see attributes/default.rb)
checksum | SHA256 checksum for Bamboo install | String | auto-detected (see attributes/default.rb)
home_path | home directory for Bamboo user | String | /var/atlassian/application-data/bamboo
install_path | location to install Bamboo | String | /opt/atlassian/bamboo
install_type | Bamboo install type - "cluster-standalone", "cluster-war", "installer", "standalone", "war" | String | installer
url_base | URL base for Bamboo install | String | http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo
url | URL for Bamboo install | String | auto-detected (see attributes/default.rb)
user | user running Bamboo | String | bamboo
version | Bamboo version to install | String | 5.1.0

### Bamboo Database Attributes

All of these `node['bamboo']['database']` attributes are overridden by `bamboo/bamboo` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

Attribute | Description | Type | Default
----------|-------------|------|--------
host | FQDN or "localhost" (localhost automatically installs `['database']['type']` server) | String | localhost
name | Bamboo database name | String | bamboo
password | Bamboo database user password | String | changeit
port | Bamboo database port | Fixnum | 3306
type | Bamboo database type - "mysql" or "postgresql" | String | mysql
user | Bamboo database user | String | bamboo

### Bamboo JVM Attributes

These attributes are under the `node['bamboo']['jvm']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
minimum_memory | JVM minimum memory | String | 512m
maximum_memory | JVM maximum memory | String | 768m
maximum_permgen | JVM maximum PermGen memory | String | 256m
java_opts | additional JAVA_OPTS to be passed to Bamboo JVM during startup | String | ""

### Bamboo Tomcat Attributes

These attributes are under the `node['bamboo']['tomcat']` namespace.

Any `node['bamboo']['tomcat']['key*']` attributes are overridden by `bamboo/bamboo` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

Attribute | Description | Type | Default
----------|-------------|------|--------
keyAlias | Tomcat SSL keystore alias | String | tomcat
keystoreFile | Tomcat SSL keystore file - will automatically generate self-signed keystore file if left as default | String | `#{node['bamboo']['home_path']}/.keystore`
keystorePass | Tomcat SSL keystore passphrase | String | changeit
port | Tomcat HTTP port | Fixnum | 8085
ssl_port | Tomcat HTTPS port | Fixnum | 8443

## Recipes

* `recipe[bamboo]` Installs/configures Atlassian Bamboo
* `recipe[bamboo::apache2]` Installs/configures Apache 2 as proxy (ports 80/443)
* `recipe[bamboo::database]` Installs/configures MySQL/Postgres server, database, and user for Bamboo
* `recipe[bamboo::linux_cluster-standalone]` Installs/configures Bamboo Cluster via Linux standalone archive"
* `recipe[bamboo::linux_cluster-war]` Deploys Bamboo Cluster WAR on Linux"
* `recipe[bamboo::linux_installer]` Installs/configures Bamboo via Linux installer"
* `recipe[bamboo::linux_standalone]` Installs/configures Bamboo via Linux standalone archive"
* `recipe[bamboo::linux_war]` Deploys Bamboo WAR on Linux"
* `recipe[bamboo::tomcat_configuration]` Configures Bamboo's built-in Tomcat
* `recipe[bamboo::windows_cluster-standalone]` Installs/configures Bamboo Cluster via Windows standalone archive"
* `recipe[bamboo::windows_cluster-war]` Deploys Bamboo Cluster WAR on Windows"
* `recipe[bamboo::windows_installer]` Installs/configures Bamboo via Windows installer"
* `recipe[bamboo::windows_standalone]` Installs/configures Bamboo via Windows standalone archive"
* `recipe[bamboo::windows_war]` Deploys Bamboo WAR on Windows"

## Usage

### Bamboo Server Data Bag

For securely overriding attributes on Hosted Chef, create a `bamboo/bamboo` encrypted data bag with the model below. Chef Solo can override the same attributes with a `bamboo/bamboo` unencrypted data bag of the same information.

_required:_
* `['database']['type']` "mysql" or "postgresql"
* `['database']['host']` FQDN or "localhost" (localhost automatically
  installs `['database']['type']` server)
* `['database']['name']` Name of Bamboo database
* `['database']['user']` Bamboo database username
* `['database']['password']` Bamboo database username password

_optional:_
* `['database']['port']` Database port, standard database port for
  `['database']['type']`
* `['tomcat']['keyAlias']` Tomcat HTTPS Java Keystore keyAlias, defaults to self-signed certifcate
* `['tomcat']['keystoreFile']` Tomcat HTTPS Java Keystore keystoreFile, self-signed certificate
* `['tomcat']['keystorePass']` Tomcat HTTPS Java Keystore keystorePass, self-signed certificate

Repeat for other Chef environments as necessary. Example:

    {
      "id": "bamboo"
      "development": {
        "database": {
          "type": "postgresql",
          "host": "localhost",
          "name": "bamboo",
          "user": "bamboo",
          "password": "bamboo_db_password",
        },
        "tomcat": {
          "keyAlias": "not_tomcat",
          "keystoreFile": "/etc/pki/java/wildcard_cert.jks",
          "keystorePass": "not_changeit"
        }
      }
    }

### Bamboo Server Installation

The simplest method is via the default recipe, which uses `node['bamboo']['install_type']` to determine best method.

* Optionally (un)encrypted data bag or set attributes
  * `knife data bag create bamboo`
  * `knife data bag edit bamboo bamboo --secret-file=path/to/secret`
* Add `recipe[bamboo]` to your node's run list.

### Custom Bamboo Configurations

Using individual recipes, you can use this cookbook to configure Bamboo to fit your environment.

* Optionally (un)encrypted data bag or set attributes
  * `knife data bag create bamboo`
  * `knife data bag edit bamboo bamboo --secret-file=path/to/secret`
* Add individual recipes to your node's run list.

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    gem install bundler --no-ri --no-rdoc
    git clone git://github.com/bflad/chef-bamboo.git
    cd chef-bamboo
    bundle install
    bundle exec vagrant up BOX # BOX being centos6 or ubuntu1204

You may need to add the following hosts entries:

* 33.33.33.10 bamboo-centos-6
* 33.33.33.11 bamboo-ubuntu-1204

The running Bamboo server is accessible from the host machine:

CentOS 6 Box:
* Web UI: https://33.33.33.10/

Ubuntu 12.04 Box:
* Web UI: https://33.33.33.11/

You can then SSH into the running VM using the `vagrant ssh` command.
The VM can easily be stopped and deleted with the `vagrant destroy`
command. Please see the official [Vagrant documentation](http://vagrantup.com/v1/docs/commands.html)
for a more in depth explanation of available commands.

## Contributing

Please use standard Github issues/pull requests and if possible, in combination with testing on the Vagrant boxes.

## License and Author

Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2013

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
