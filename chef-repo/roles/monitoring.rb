name "monitoring"
description "The monitoring server role.  This role is just for the monitoring server itself."

run_list(
  #"recipe[munin::server]",
  "recipe[nagios::server]",
  "recipe[postfix]"
)

override_attributes(
  "nagios" => { "notifications_enabled" => "0" },
  "postfix" => { "myhostname" => "nagios", "mydomain" =>"eartheconomics.org" }
)

default_attributes(
  "nagios" => { "server_auth_method" => "htauth",
                "multi_environment_monitoring" => true },

  "munin" => { "server_auth_method" => "htauth",
               "web_server_port" => 81 }
)
