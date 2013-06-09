#
# Cookbook Name:: development
# Recipe:: revel

package %w{mercurial git-core} do
  action :install
end

execute "revel" do
  command "go get github.com/robfig/revel/revel"
  action :run
end


bash "GOPATH /etc/environment" do
  code <<-EOH
    export PATH="$PATH:$GOPATH/bin
    echo 'PATH="$PATH:$GOPATH/bin"' >> /etc/environment
  EOH

  not_if "echo $GOPATH"
end


# /etc/environment
# export PATH="$PATH:$GOPATH/bin"
# echo 'PATH="$PATH:$GOPATH/bin"' >> .bash_profile
