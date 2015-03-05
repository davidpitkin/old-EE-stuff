default["ee-jira"]["secret_file"] = "/home/jira/secret_key"

aws_blocks = ['10.0.0.0/8', '54.245.0.0/16', '54.241.0.0/16' ]

north_america_blocks = [
                        '23.0.0.0/8', '24.0.0.0/8', '50.0.0.0/8', '63.0.0.0/8', '64.0.0.0/8',
                        '65.0.0.0/8', '66.0.0.0/8', '67.0.0.0/8', '68.0.0.0/8', '69.0.0.0/8',
                        '70.0.0.0/8', '71.0.0.0/8', '72.0.0.0/8', '73.0.0.0/8', '74.0.0.0/8',
                        '75.0.0.0/8', '76.0.0.0/8', '96.0.0.0/8', '97.0.0.0/8', '98.0.0.0/8',
                        '99.0.0.0/8', '100.0.0.0/8', '104.0.0.0/8', '107.0.0.0/8', '108.0.0.0/8',
                        '173.0.0.0/8', '174.0.0.0/8', '184.0.0.0/8', '199.0.0.0/8', '204.0.0.0/8',
                        '205.0.0.0/8',
                        '206.0.0.0/8', '207.0.0.0/8', '208.0.0.0/8', '209.0.0.0/8',
                        '216.0.0.0/8', '192.211.16.0/20', '131.191.0.0/16' ]

uw_blocks =            [
                        '128.208.0.0/16', '128.95.0.0/16' , '140.142.0.0/16',
                        '198.48.64.0/19', '205.175.96.0/19', '69.91.128.0/17',
                        '173.250.128.0/17', '108.179.128.0/18' ]

allowed_blocks = aws_blocks + north_america_blocks + uw_blocks

default[:afw][:enable] = true
default[:afw][:enable_input_drop] = true
default[:afw][:enable_output_drop] = false

default[:afw][:rules] = {
  'allow Jira HTTP from NA' => {
    'direction' => 'in',
    'protocol' => 'tcp',
    'user' => 'jira',
    'interface' => 'eth0',
    'source' => allowed_blocks,
    'dport' => '80'
  },
  'allow Remote Bamboo Agent from transform-dev' => {
    'direction' => 'in',
    'protocol' => 'tcp',
    'user' => 'jira',
    'interface' => 'eth0',
    'source' => allowed_blocks,
    'dport' => '80'
  }
}
