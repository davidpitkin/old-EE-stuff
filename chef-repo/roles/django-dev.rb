name "django-dev"
description "Server role for generic Django development environment"

run_list(
  "role[server]",
  "recipe[users]",
  "recipe[users::sysadmins]",
  "recipe[ee-utils::django]",
  "recipe[evt-word-import-tool]",
)

default_attributes(
  "build_essential" => {
      "compiletime" => true
  },

  "authorization" => {
    "sudo" => {
        "groups" => [ "sysadmin", "deploy", "admin", "adm", "eng" ],
        "users" => [ "ubuntu", "deploy", "jgerrish", "lscott", "ec2-user" ],
        "passwordless" => true
    }
  },

  "nagios" => {
    "server_role" => "monitoring",
      "multi_environment_monitoring" => true
  }
)

override_attributes(
    "user" => {
        "ssh_keygen" => false
    },
    "evt-word-import-tool" => {
        "secret_file" => "/home/ubuntu/.ssh/encrypted_data_bag_secret_key"
    }
)
