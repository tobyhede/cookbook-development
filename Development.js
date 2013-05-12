{
  "name": "Development",
  "description": "Vagrant development",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
    "authorization": {
      "sudo": {
        "users": [ "vagrant" ]
      }
    },
    "rbenv_ruby": {
      "global": "true",
      "ruby_version": "1.9.3-p392"
    },
    "postgresql": {
      "version": "9.2",
      "enable_pitti_ppa": "true",
      "password": {
        "postgres": "pwd"
      }
    },
    "rbenv": {
      "group_users": [
        "vagrant"
      ]
    }
  },
  "chef_type": "role",
  "run_list": [
    "recipe[rbenv]",
    "recipe[development]"
  ],
  "env_run_lists": {
  }
}
