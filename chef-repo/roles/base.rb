name "base"
description "Base role applied to all nodes"

run_list(
  "recipe[vim]",
  "recipe[apt-if-appropriate]",
  "recipe[build-essential]",
  "recipe[git]",
  "recipe[sudo]"
)

default_attributes(
  "chef_client" => {
    "server_url" => "http://ec2-54-245-143-104.us-west-2.compute.amazonaws.com:4000",
    "validation_client_name" => "chef-validator"
  },
  "build_essential" => {
    "compiletime" => true
  }
)
