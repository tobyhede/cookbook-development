#
# Cookbook Name:: development
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

ruby_block "apt-get-update" do
  block do
    `apt-get update`
  end
  action :create
end

include_recipe "apt"

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

include_recipe "database"
include_recipe "postgresql::ppa_pitti_postgresql"
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

postgresql_database 'octane_dev' do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :create
end

postgresql_database 'octane_test' do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :create
end
