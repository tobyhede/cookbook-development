#
# Cookbook Name:: development
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

ruby_block "apt-get-update" do
  block do
    `apt-get update`
  end
  action :create
end

# include_recipe "development::ruby"
# include_recipe "development::go"
# include_recipe "development::elasticsearch"
# include_recipe "development::postgresql"
include_recipe "development::postgresql_source"



