log_level                :info
log_location             STDOUT
node_name                'agenerette'
client_key               '~/chef/EE/chef-repo/.chef/agenerette.pem'
validation_client_name   'chef-validator'
#validation_key           '/etc/chef/validation.pem'
chef_server_url          'http://ec2-54-245-143-104.us-west-2.compute.amazonaws.com:4000'
cookbook_path            '/Users/abgenerette/chef/EE/chef-repo/site-cookbooks'
cache_type               'BasicFile'
#cache_options( :path => '/home/agenerette/.chef/checksums' )
