name "rails_app"
description "Generic rails app role"

run_list(
  "role[server]",
  "role[chef-client]",
  "recipe[application]"
)
