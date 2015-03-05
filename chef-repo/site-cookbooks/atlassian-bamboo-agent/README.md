atlassian-bamboo-agent Cookbook
===============================
This cookbook installs and configures an Atlassian Bamboo Remote Agent on a
system.

Requirements
------------
This cookbook require a Java JRE, version 1.5 or above.

Java is installed with the java cookbook in

#### packages
- `java` - atlassian-bamboo-agent needs java.

Attributes
----------
#### atlassian-bamboo-agent::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['atlassian-bamboo-agent']['remote_agent_jar']</tt></td>
    <td>String</td>
    <td>Filename of the JAR file for the remote agent</td>
    <td><tt>atlassian-bamboo-agent-installer-4.3.3.jar</tt></td>
  </tr>
  <tr>
    <td><tt>['atlassian-bamboo-agent']['remote_agent_jar_url']</tt></td>
    <td>String</td>
    <td>URL where the agent recipe can download the Remote Agent JAR file.
    This is created via Bamboo under Installing a Remote Agent.</td>
    <td><tt>http://bamboo.server/agentServer/agentInstaller/atlassian-bamboo-agent-installer-4.3.3.jar</tt></td>
  </tr>
  <tr>
    <td><tt>['atlassian-bamboo-agent']['remote_agent_jar_md5']</tt></td>
    <td>String</td>
    <td>MD5 checksum of the jar file</td>
    <td><tt>3a300e3c60e6aabb560897531907bc73</tt></td>
  </tr>
  <tr>
    <td><tt>['atlassian-bamboo-agent']['agent_server_url']</tt></td>
    <td>String</td>
    <td>URL the remote agent will connect to.  Usually this is a Bamboo URL subpath</td>
    <td><tt>http://bamboo.server/agentServer/</tt></td>
  </tr>
  <tr>
    <td><tt>['atlassian-bamboo-agent']['bamboo_user']</tt></td>
    <td>String</td>
    <td>User to run the Remote Agent as</td>
    <td><tt>jira</tt></td>
  </tr>
  <tr>
    <td><tt>['atlassian-bamboo-agent']['bamboo_group']</tt></td>
    <td>String</td>
    <td>Group to run the Remote Agent as</td>
    <td><tt>jira</tt></td>
  </tr>
  <tr>
    <td><tt>['atlassian-bamboo-agent']['bamboo_home']</tt></td>
    <td>String</td>
    <td>directory to the remote agent will use as its home and store data in</td>
    <td><tt>USER_HOME/bamboo-agent-home</tt></td>
  </tr>
</table>

Usage
-----
#### atlassian-bamboo-agent::default

Just include `atlassian-bamboo-agent` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[atlassian-bamboo-agent]"
  ]
}
```

License and Authors
-------------------
Authors: Earth Economics 2013
