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

