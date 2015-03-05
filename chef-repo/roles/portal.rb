name "portal"
description "The Portal application."

run_list(
  "role[php_app]",
  # Eventually we want the PostgreSQL server installed automatically, but it
  # needs to be configured still
  #"recipe[postgresql::server]",
  "recipe[mysql::client]",
  "recipe[mysql::ruby]",
  "recipe[portal::default]",
  "recipe[portal::backup]"
)

default_attributes(
  "portal_db" => {
    "name" => "eartheconomics",
    "username" => "root",
    "password" => ""
  }
)
