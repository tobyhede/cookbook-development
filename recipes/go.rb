#
# Cookbook Name:: development
# Recipe:: go

# /usr/lib/go/
node.set[:go][:gopath] = "/opt/gocode"

include_recipe "golang::default"



# Make a directory: mkdir ~/gocode
# Tell Go to use that as your GOPATH: export GOPATH=~/gocode
# Save your GOPATH so that it will apply to all future shell sessions: echo GOPATH=$GOPATH >> .bash_profile

directory node[:go][:gopath] do
  mode 0755
  action :create
end


magic_shell_environment 'GOPATH' do
  value node[:go][:gopath]
end

# bash "SET GOPATH /etc/environment" do
#   code <<-EOH
#     echo 'GOPATH=#{node[:go][:gopath]}' >> /etc/environment
#   EOH
#
#   not_if "echo $GOPATH | grep #{node[:go][:gopath]}"
# end
#
# export PATH=YOUR_PATH_WITHOUT_TRAILING_SLASH:$PATH

# magic_shell_environment 'PATH' do
#   value "$PATH:$GOPATH/bin"
# end

bash "Add GOPATH to PATH /etc/environment" do
  code <<-EOH
    echo "PATH=$PATH:$GOPATH/bin" >> /etc/environment
  EOH
  # not_if "echo $PATH | grep $GOPATH"
end



# rbenv_gem "guard" do
#   ruby_version node["rbenv_ruby"]["ruby_version"]
# end

# rbenv_gem "guard-go" do
#   ruby_version node["rbenv_ruby"]["ruby_version"]
# end

# bundle exec guard init go
