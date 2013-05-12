#
# Cookbook Name:: development
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "Update locale" do
  command "update-locale LANGUAGE=#{node[:locale][:lang]}"
  # echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

  not_if "cat /etc/default/locale | grep -qx LANGUAGE=#{node[:locale][:lang]}"
end

ruby_block "apt-get-update" do
  block do
    `apt-get update`
  end
  action :create
end

# directory node["postgresql"]["dir"] do
#   # owner "root"
#   # group "root"
#   # mode 00644
#   action :create
# end


include_recipe "apt"

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

include_recipe "database"
include_recipe "postgresql::ppa_pitti_postgresql"
include_recipe "postgresql::client"
include_recipe "postgresql::server"
include_recipe "postgresql::ruby"

rbenv_ruby node["rbenv_ruby"]["ruby_version"] do
  ruby_version node['rbenv_ruby']['ruby_version']
  global true
  force false
end

rbenv_gem "bundler" do
  ruby_version node["rbenv_ruby"]["ruby_version"]
end



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
