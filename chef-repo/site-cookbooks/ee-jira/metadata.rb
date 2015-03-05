name             'ee-jira'
maintainer       'Earth Economics'
maintainer_email 'jgerrish@eartheconomics.org'
license          'All rights reserved'
description      'Installs/Configures Atlassian Jira'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          "AFW"
depends          "apt"
depends          'users'
depends          'java'
depends          'apache2'
depends          'database'
depends          'mysql'
depends          'application'
depends          'jira'
depends          'logrotate'
