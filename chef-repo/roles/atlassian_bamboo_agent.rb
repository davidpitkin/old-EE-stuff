name "atlassian_bamboo_agent"
description "Server role for generic servers"

run_list(
  "role[server]",
  "recipe[user::data_bag]",
  "recipe[atlassian-bamboo-agent]"
)

default_attributes(
  "atlassian-bamboo-agent" => {
    "remote_agent_jar_url" => "http://bamboo.esvaluation.org/agentServer/agentInstaller/atlassian-bamboo-agent-installer-4.3.3.jar",
    "agent_server_url" => "http://bamboo.esvaluation.org/agentServer/"
  }
)

override_attributes(
  "user" => {
    "ssh_keygen" => false
  }
)
