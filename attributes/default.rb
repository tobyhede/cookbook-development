default["locale"]["lang"] = "en_US.utf8"

default["rbenv_ruby"]["ruby_version"] = "1.9.3-p392"
default["rbenv_ruby"]["global"] = "true"


# default["postgresql"]["dir"] = "/opt/postgresql"
# default["postgresql"]["server"]["service_name"] = "postgresql"

default["postgresql"]["client"]["packages"] = ["postgresql-client-common","postgresql-client-9.2"]
default["postgresql"]["server"]["packages"] = ["postgresql-9.2"]