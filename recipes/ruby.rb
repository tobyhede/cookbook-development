#
# Cookbook Name:: development
# Recipe:: ruby

node.set['rbenv_ruby']['ruby_version']  = "1.9.3-p392"
node.set['rbenv_ruby']['global']    = "true"
node.set['rbenv']['group_users']    = ["vagrant"]

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node["rbenv_ruby"]["ruby_version"] do
  ruby_version node['rbenv_ruby']['ruby_version']
  global true
  force false
end

rbenv_gem "bundler" do
  ruby_version node["rbenv_ruby"]["ruby_version"]
end

