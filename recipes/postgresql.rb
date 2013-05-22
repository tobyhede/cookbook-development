#
# Cookbook Name:: development
# Recipe:: postgresql

node.set['postgresql']['version']          = "9.2"
node.set['postgresql']['enable_pitti_ppa'] = "true",
node.set['postgresql']['password']         = {postgres: "pwd"}

node.set['locale']['lang']                 = "en_US.utf8"

execute "Update locale" do
  command "update-locale LANGUAGE=#{node[:locale][:lang]}"
  not_if "cat /etc/default/locale | grep -qx LANGUAGE=#{node[:locale][:lang]}"
end


# include_recipe "postgresql::ppa_pitti_postgresql"
# include_recipe "postgresql::client"
include_recipe "postgresql::server"
include_recipe "postgresql::ruby"
include_recipe "database"

# apt_repository 'pitti-postgresql-ppa' do
#   uri 'http://ppa.launchpad.net/pitti/postgresql/ubuntu'
#   distribution node['lsb']['codename']
#   components %w(main)
#   keyserver 'keyserver.ubuntu.com'
#   key '8683D8A2'
#   action :add
# end

# apt_repository("apt.postgresql.org") do
#   uri "http://apt.postgresql.org/pub/repos/apt"
#   components ["main"]
#   # distribution "lucid-pgdg"
#   distribution node['lsb']['codename']
#   action [:add]
#   key "http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc"
# end


postgresql_database 'octane_dev' do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :create
end

postgresql_database 'octane_test' do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :create
end