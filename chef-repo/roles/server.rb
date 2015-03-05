name "server"
description "Server role for generic servers"

run_list(
  "role[chef-client]",
  "role[base]",
  "recipe[users]",
  "recipe[users::sysadmins]",
  "recipe[user::data_bag]",
  "recipe[nagios::client]"
)

# Firewall configuration

aws_blocks = ['10.0.0.0/8', '54.245.0.0/16', '54.241.0.0/16', '192.168.0.0/16' ]

north_america_blocks = [
                        '23.0.0.0/8', '24.0.0.0/8', '50.0.0.0/8', '63.0.0.0/8', '64.0.0.0/8',
                        '65.0.0.0/8', '66.0.0.0/8', '67.0.0.0/8', '68.0.0.0/8', '69.0.0.0/8',
                        '70.0.0.0/8', '71.0.0.0/8', '72.0.0.0/8', '73.0.0.0/8', '74.0.0.0/8',
                        '75.0.0.0/8', '76.0.0.0/8', '96.0.0.0/8', '97.0.0.0/8', '98.0.0.0/8',
                        '99.0.0.0/8', '100.0.0.0/8', '104.0.0.0/8', '107.0.0.0/8', '108.0.0.0/8',
                        '173.0.0.0/8', '174.0.0.0/8', '184.0.0.0/8', '199.0.0.0/8', '204.0.0.0/8',
                        '205.0.0.0/8', '206.0.0.0/8', '207.0.0.0/8', '208.0.0.0/8', '209.0.0.0/8',
                        '216.0.0.0/8', '192.211.16.0/20',
                        '131.191.0.0/16', '128.95.0.0/16', '137.229.0.0/16', '140.142.0.0/16',
                        '166.147.0.0/16', '128.208.0.0/16'
                       ]
                       
international_allowed_blocks = [ 
   '36.250.0.0/16',  '36.251.0.0/16', 
   '36.252.0.0/16',  '36.253.0.0/16', '36.254.0.0/16',  '36.255.0.0/16', 
   '49.126.0.0/16',
   '103.9.0.0/16', '110.44.0.0/16', '110.34.0.0/16',
   '122.166.0.0/16', '122.167.0.0/16', '122.168.0.0/16', '122.169.0.0/16', '122.170.0.0/16',
   '122.171.0.0/16', '122.172.0.0/16', '122.173.0.0/16', '122.174.0.0/16', '122.175.0.0/16', '122.176.0.0/16',
   '122.177.0.0/16', '122.178.0.0/16', '122.179.0.0/16', 
   '182.174.0.0/16', '182.175.0.0/16', '182.176.0.0/16', '182.177.0.0/16', '182.178.0.0/16', '182.179.0.0/16', 
   '182.180.0.0/16', '182.181.0.0/16', '182.182.0.0/16', '182.183.0.0/16', '182.184.0.0/16', '182.185.0.0/16', 
   '202.169.0.0/16', '222.165.0.0/16', 
   '27.34.0.0/16','112.209.0.0/16'
   ]

allowed_blocks = aws_blocks + north_america_blocks + international_allowed_blocks


default_attributes(
   :afw => {
     :enable => true,
     :enable_input_drop => true,
     :enable_output_drop => false,
     :rules => {
       'allow SSH from NA' => {
         'direction' => 'in',
         'protocol' => 'tcp',
         'user' => 'deploy',
         'interface' => 'eth0',
         'source' => allowed_blocks,
         'dport' => '22'
       },
       'allow ICMP from AWS' => {
         'direction' => 'in',
         'protocol' => 'icmp',
         'user' => 'root',
         'interface' => 'eth0',
         'source' => aws_blocks
       },
       'allow HTTP from NA' => {
         'direction' => 'in',
         'protocol' => 'tcp',
         'user' => 'root',
         'interface' => 'eth0',
         'source' => allowed_blocks,
         'dport' => '80'
       },
       'allow NRPE from NA' => {
         'direction' => 'in',
         'protocol' => 'tcp',
         'user' => 'root',
         'interface' => 'eth0',
         'source' => allowed_blocks,
         'dport' => '5666'
       }
     }
  },

  "authorization" => {
    "sudo" => {
      "groups" => [ "sysadmin", "admin", "adm" ],
      "users" => [ "aschwartz", "ccooley", "jgerrish",
                   "nwahlund", "rbernier" ],
      "passwordless" => true
    }
  },
  "users" => ["jchin", "deploy", "jgerrish", "ccooley", "aschwartz" ],

  "nagios" => {
    "server_role" => "monitoring",
    "multi_environment_monitoring" => true
  }
)

override_attributes(
  "user" => {
    "ssh_keygen" => false
  }
)
