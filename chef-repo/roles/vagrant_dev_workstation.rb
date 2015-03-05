name "vagrant_dev_workstation"
description "Role applied to Vagrant dev workstations"

run_list(
  "role[workstation]",
  "recipe[postgresql::client]",
  "recipe[postgresql::server]",
  "recipe[rvm::user]",
  "recipe[rvm::vagrant]",
  #"recipe[ee-utils::ee-dev-vagrant]",
  "recipe[emacs]"
)

default_attributes(
  "chef_client" => {
    "server_url" => "http://ec2-54-245-143-104.us-west-2.compute.amazonaws.com:4000",
    "validation_client_name" => "chef-validator"
  },
  "authorization" => {
    "sudo" => {
      "groups" => [ "sysadmin", "deploy", "admin", "adm", "eng" ],
      "users" => [ "jmaddock", "ccooley", "ubuntu", "deploy", "jgerrish", "ec2-user" ],
      "passwordless" => true
    }
  },
  "users" => ["jmaddock", "jgerrish", "vagrant", "ccooley", "ubuntu", "deploy"],

  "emacs" => { "24" => true },

  # RVM cookbook data
  "rvm" => {
    "installer_url" => "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer",
    "branch" => "none",
    "version" => "1.17.10",
    "user_rubies" => [ "ruby-1.9.3-p392", "ruby-1.9.3-p374" ],
    "default_ruby" => "ruby-1.9.3-p392",
    "user_default_ruby" => "ruby-1.9.3-p392",
    "user_rubies" => [ "ruby-1.9.3-p392" ],
    "gems" => {
       "ruby-1.9.3-p374@evt-transform" => {
       "name" => "rails",
       "version" => "3.2.13"
     }
   },
   "user_installs" => [ {
     'user'          => 'vagrant',
     'default_ruby'  => 'ruby-1.9.3-p392',
     'rubies'        => ['1.9.3-p374']
     },
     {
       'user'          => 'jgerrish',
       'default_ruby'  => 'ruby-1.9.3-p392',
       'rubies'        => ['1.9.3-p374']
     }
   ]
 }

)

#override_attributes(
  #"user" => {
  #  "ssh_keygen" => false
  #},

  # "authorization" => {
  #   "sudo" => {
  #     "groups" => ["admin"],
  #     "users" => ["jgerrish", "vagrant"],
  #     "passwordless" => true
  #   }
  # }
#)
