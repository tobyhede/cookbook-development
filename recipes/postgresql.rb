#
# Cookbook Name:: development
# Recipe:: postgresql

node.set['postgresql']['version'] = "9.3"
node.set['postgresql']['dir'] = "/var/lib/postgresql/#{node['postgresql']['version']}/main"
node.set['postgresql']['client']['packages'] = ["postgresql-client-#{node['postgresql']['version']}"]
node.set['postgresql']['server']['packages'] = ["postgresql-#{node['postgresql']['version']}"]

# node.set['postgresql']['dir'] = "/etc/postgresql/9.2/main"
node.set['postgresql']['enable_pgdg_apt'] = true
node.set['postgresql']['password'] = {postgres: "pwd"}
node.set['postgresql']['config']['ssl'] = false

# node.set['postgresql']['client']['packages']  = ["postgresql-client-9.2", "libpq-dev"]
# node.set['postgresql']['server']['packages'] = ["postgresql-9.2"]

node.set['locale']['lang'] = "en_US.utf8"

execute "Update locale" do
  command "update-locale LANGUAGE=#{node[:locale][:lang]}"
  not_if "cat /etc/default/locale | grep -qx LANGUAGE=#{node[:locale][:lang]}"
end


# wget http://www.example.com/program-#{node[:program][:version]}.tar.gz -O /tmp/program-#{node[:program][:version]}.tar.gz
# tar -zxf program-#{node[:program][:version]}.tar.gz
# (cd program-#{node[:program][:version]}/ && ./configure && make && make install)



# http://ftp.postgresql.org/pub/source/v9.3beta1/postgresql-9.3beta1.tar.gz

node.set[:postgresql][:src][:version] = "postgresql-9.3beta1"
node.set[:postgresql][:src][:file] = "#{node[:postgresql][:src][:version]}.tar.gz"
node.set[:postgresql][:src][:checksum] = "aed1847ebd531bc6ba935ca13d0c299a"


remote_file "/tmp/#{node[:postgresql][:src][:file]}" do
  source "http://ftp.postgresql.org/pub/source/v9.3beta1/#{node[:postgresql][:src][:file]}"
  checksum node[:postgresql][:src][:checksum]
  notifies :run, "bash[install_postgresql_from_source]", :immediately
end


bash "install_postgresql_from_source" do
  # not_if "/usr/local/bin/program --version | grep -q '#{node[:program][:version]}'"
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf #{node[:postgresql][:src][:file]}
    (cd #{node[:postgresql][:src][:version]}/ && ./configure && make && make install)
    action :nothing
  EOH
end

user "postgres" do
  comment "postgres User"
end


# execute "PURGE" do
#   command "yes | sudo apt-get --purge remove postgresql\*"
# end

# include_recipe "postgresql::apt_pgdg_postgresql"

# execute "install libpq5" do
#   command "sudo apt-get install libpq5"
# end

# include_recipe "postgresql::client"

# include_recipe "postgresql::server"

# apt-get install -t precise-pgdg postgresql-client-9
package "postgresql-client-9.3" do
  options("--target-release precise-pgdg")
end


include_recipe "postgresql::server"

# include_recipe "postgresql::ruby"
# include_recipe "database::postgresql"


# postgresql_database 'octane_dev' do
#   connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
#   action :create
# end

# postgresql_database 'octane_test' do
#   connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
#   action :create
# end
