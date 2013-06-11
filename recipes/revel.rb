#
# Cookbook Name:: development
# Recipe:: revel

%w{mercurial git-core}.each do |package_name|
  package package_name do
    action :install
  end
end

execute "revel" do
  command "go get github.com/robfig/revel/revel"
  action :run
end


# /etc/environment
# export PATH="$PATH:$GOPATH/bin"
# echo 'PATH="$PATH:$GOPATH/bin"' >> .bash_profile
