name "php_app"
description "Generic PHP app role"

run_list(
  "role[server]",
  "role[chef-client]",
  "recipe[application]"
)
