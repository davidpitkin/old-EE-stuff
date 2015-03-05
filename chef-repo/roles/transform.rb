name "transform"
description "The TransForm application."

run_list(
  "role[rails_app]",
  # Eventually we want the PostgreSQL server installed automatically, but it
  # needs to be configured still
  #"recipe[postgresql::server]",
  "recipe[postgresql::client]",
  "recipe[transform::backup]",
  "recipe[transform::default]"
)


default_attributes(

  "users" => ["jchin", "ubuntu", "deploy", "jgerrish", "ccooley"  ],

  "authorization" => {
    "sudo" => {
      "groups" => [ "sysadmin", "admin", "adm" ],
      "users" => [ "ubuntu", "ccooley", "jgerrish" ],
      "passwordless" => true
    }
  },

  "transform_db" => {
    "name" => "transform_production",
    "username" => "rails",
    "password" => ""
  }
)
