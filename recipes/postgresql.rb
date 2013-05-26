#
# Cookbook Name:: development
# Recipe:: postgresql

node.set['postgresql']['version'] = "9.2"
node.set['postgresql']['dir'] = "/var/lib/postgresql/#{node['postgresql']['version']}/main"
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

# execute "PURGE" do
#   command "yes | sudo apt-get --purge remove postgresql\*"
# end

include_recipe "postgresql::apt_pgdg_postgresql"
# include_recipe "postgresql::client"
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
