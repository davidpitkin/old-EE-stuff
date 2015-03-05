name "jira-server"
description "role for Jira server"

run_list(
         "role[server]",
         "recipe[java]",
         "recipe[ee-jira]",
         "recipe[ee-confluence]"
        )

default_attributes(

  "java" => {
    "install_flavor" => "oracle",
       "oracle" => {
       "accept_oracle_download_terms" => true,
    }
  },
  "mysql" => {
    "bind_address" => "127.0.0.1"
  },
  "jira" => {
    "user" => "jira",
    "mysql" => {
      "bind_address" => "127.0.0.1"
     },
     "database" => { "host" => "localhost", "name" => "jira", "user" => "jira" }
  },
  "confluence" => {
    "user" => "confluence",
    "mysql" => {
      "bind_address" => "127.0.0.1"
    },
    "database" => { "host" => "localhost", "name" => "confluence", "user" => "confluence" }
  },
  "authorization" => {
    "sudo" => {
      "groups" => [ "sysadmin", "admin", "adm" ],
      "users" => [ "aschwartz", "ccooley", "ec2-user",
                   "jgerrish", "nwahlund", "rbernier" ],
      "passwordless" => true
    }
  },
  "users" => ["jira", "confluence", "deploy", "jgerrish",
              "ccooley", "aschwartz" ],

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
