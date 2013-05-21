#
# Cookbook Name:: development
# Recipe:: go

include_recipe "golang::default"

rbenv_gem "guard" do
  ruby_version node["rbenv_ruby"]["ruby_version"]
end

rbenv_gem "guard-go" do
  ruby_version node["rbenv_ruby"]["ruby_version"]
end


# bundle exec guard init go
