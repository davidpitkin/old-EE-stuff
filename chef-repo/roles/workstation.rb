name "workstation"
description "Base role applied to personal workstations"

run_list(
  "role[chef-client]",
  "recipe[vim]",
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[git]",
  "recipe[users]",
  "recipe[users::sysadmins]",
  #"recipe[users::data_bag]",
  "recipe[sudo]",
)

default_attributes(
  "chef_client" => {
    "server_url" => "http://ec2-54-245-143-104.us-west-2.compute.amazonaws.com:4000",
    "validation_client_name" => "chef-validator"
  },
  "authorization" => {
    "sudo" => {
      "groups" => [ "sysadmin", "deploy", "admin", "adm", "eng" ],
      "users" => [ "ubuntu", "deploy", "ccooley", "jgerrish", "lscott", "ec2-user" ],
      "passwordless" => true
    }
  },
  "users" => ["ubuntu", "vagrant", "ccooley", "jgerrish", "deploy"]
)

#override_attributes(
  #"user" => {
  #  "ssh_keygen" => false
  #},

  #"authorization" => {
  #  "sudo" => {
  #    "groups" => ["admin"],
  #    "users" => ["jgerrish", "vagrant"],
  #    "passwordless" => true
  #  }
  #}
#)
