name "chef-client"
description "Chef client role"

run_list(
  "recipe[chef-client::config]",
  "recipe[chef-client::service]"
#  "recipe[chef-client::delete_validation]",
)

override_attributes(
  "chef_client" => {
     "init_style" => "init"
  }
)

