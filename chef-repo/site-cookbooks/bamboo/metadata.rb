name              "bamboo"
maintainer        "Brian Flad"
maintainer_email  "bflad@wharton.upenn.edu"
license           "Apache 2.0"
description       "Installs/Configures Atlassian Bamboo.  Based on Brian Flad's Confluence cookbook.'"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "bamboo", "Installs/configures Atlassian Bamboo"
recipe            "bamboo::apache2", "Installs/configures Apache 2 as proxy (ports 80/443)"
recipe            "bamboo::database", "Installs/configures MySQL/Postgres server, database, and user for Bamboo"
recipe            "bamboo::linux_standalone", "Installs/configures Bamboo via Linux standalone archive"
recipe            "bamboo::linux_war", "Deploys Bamboo WAR on Linux"
recipe            "bamboo::tomcat_configuration", "Configures Bamboo's built-in Tomcat"

%w{ amazon centos redhat scientific ubuntu }.each do |os|
  supports os
end

%w{ apache2 database mysql mysql_connector postgresql }.each do |cb|
  depends cb
end

%w{ java }.each do |cb|
  suggests cb
end
