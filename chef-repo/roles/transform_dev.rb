name "transform_dev"
description "TransForm development application."
# Create with:
# knife ec2 server create -r "role[transform_dev]" -I ami-48d94c78 -f t1.micro -S aws-chef-key -i ~/.ssh/aws-chef-key.pem --ssh-user ubuntu --region us-west-2 -N pchristopher-mas-dat
#

run_list(
         #"role[transform]",
         "role[rails_app]",
         # Eventually we want the PostgreSQL server installed automatically, but it
         # needs to be configured still
         "recipe[postgresql::client]",
         "recipe[postgresql::server]",
         "recipe[sqlite]",
         "recipe[users]",
         "recipe[users::sysadmins]",
         "recipe[transform-dev::default]"
         #"recipe[rvm::user]"
        )

default_attributes(
   "transform_db" => {
     "name" => "transform_production",
     "username" => "rails",
     "password" => ""
   },

  "authorization" => {
    "sudo" => {
      "groups" => [ "sysadmin", "admin", "adm" ],
      "users" => [ "ubuntu", "ccooley", "jgerrish" ],
      "passwordless" => true
    }
  },
  "build_essential" => {
    "compiletime" => true
  },
  "users" => ["ubuntu", "deploy", "jgerrish", "jchin", "ccooley" ],

  "passenger" => { "root_path" => "/home/deploy/.rvm/gems/ruby-1.9.3-p448@evt-transform/gems/passenger-3.0.19" },
  "languages" => { "ruby" => { "ruby_bin" => "/home/deploy/.rvm/wrappers/ruby-1.9.3-p448@evt-transform/ruby" } },

  # RVM cookbook data
  "rvm" => {
    "rvmrc" => {
      "rvm_trust_rvmrcs_flag" => 1
    },
    "default_ruby" => "ruby-1.9.3-p448",
    "user_default_ruby" => "ruby-1.9.3-p448",
    "gems" => {
      "ruby-1.9.3-p448@twic" => {
        "name" => "rails",
        "version" => "4.0.0"
      }
    },
    "user_installs" => [
      { 'user'           => 'deploy',
        'install_rubies' => true,
        'default_ruby'   => 'ruby-1.9.3-p448',
        'rubies'         => ['1.9.3-p448']
      },
      { 'user'           => 'jgerrish',
        'install_rubies' => true,
        'default_ruby'   => 'ruby-1.9.3-p448',
        'rubies'         => ['1.9.3-p448']
      }
     ]
    }
)

override_attributes(
  # 'postgresql' => {
  #   'pg_hba' => [
  #     { :type => 'local', :db => 'twic_dev', :user => "rails", :method => 'trust' },
  #     { :type => 'local', :db => 'twic_test', :user => "rails", :method => 'trust' },
  #     { :type => 'local', :db => 'twic_prod', :user => "rails", :method => 'trust' },
  #     { :method => 'trust', :address => '127.0.0.1/32' },
  #   ]
  # },
  "setup_items" => {
    "users" => [
      { "username" => "rails" },
    ],
    "databases" => [
      { "name" => "twic_prod",
        "owner" => "rails",
        "adapter" => "postgresql"
      },
      { "name" => "twic_dev",
        "owner" => "rails",
        "adapter" => "postgresql"
      },
      { "name" => "twic_test",
        "owner" => "rails",
        "adapter" => "postgresql"
      }
    ]
  },
  "transform-dev" => {
    "secret_file" => "/home/ubuntu/.ssh/encrypted_data_bag_secret_key"
  }
)
