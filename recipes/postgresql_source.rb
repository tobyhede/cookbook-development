#
# Cookbook Name:: development
# Recipe:: postgresql_source

# http://ftp.postgresql.org/pub/source/v9.3beta1/postgresql-9.3beta1.tar.gz

node.set[:postgresql_src][:version]     = "9.3beta1"

node.set[:postgresql_src][:remote_tar]  = "http://ftp.postgresql.org/pub/source/v#{node[:postgresql_src][:version]}/postgresql-#{node.set[:postgresql_src][:version]}.tar.gz"

node.set[:postgresql_src][:packages]    = %w{build-essential libreadline6-dev zlib1g-dev}

node.set[:postgresql_src][:data_dir]    = "/usr/local/pgsql/data"

node.set[:postgresql_src][:bin_dir]     = "/usr/local/pgsql/bin"

node.set[:postgresql_src][:connections] = {"10.0.0.0/16" => "trust"}

node.set[:postgresql_src][:replication] = {}


conf = {
  listen_addresses: "*"
}

node.set[:postgresql_src][:conf]        = conf


# puts "========================================"
# puts node[:postgresql_src][:version]
# puts node[:postgresql_src][:remote_tar]
# puts "========================================"


tarfile = "#{Chef::Config[:file_cache_path]}/postgresql-#{node[:postgresql_src][:version]}.tar.gz"
src_dir = "#{Chef::Config[:file_cache_path]}/postgresql-#{node[:postgresql_src][:version]}"

node[:postgresql_src][:packages].each do |package_name|
  package package_name do
    action :install
  end
end

remote_file tarfile do
  source node[:postgresql_src][:remote_tar]
  mode 00644
  not_if { File.exist?(tarfile) }
end

bash 'install postgres from source' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf #{src_dir}
    tar zxvf #{tarfile}
    cd #{src_dir}
    ./configure
    make
    make install
  EOH

  not_if "ls -1 #{node[:postgresql_src][:bin_dir]}/postgres"
end

# user "postgres" do
#   action :create
# end

group "postgres" do
  action :create
end

# create postgres user if not already there
user "postgres" do
  comment "PostgreSQL User"
  group "postgres"
  home "/var/pgsql"
  action :create
end

# execute "sudo adduser postgres" do
#   command "sudo adduser postgres"
#   action :run
# end

sudo "postgres" do
  user      "postgres"
  nopasswd  true
end


directory node[:postgresql_src][:data_dir] do
  owner "postgres"
  group "postgres"
  mode 0700
  action :create
end

execute "initdb" do
  user "postgres"
  command "#{node[:postgresql_src][:bin_dir]}/initdb -D #{node[:postgresql_src][:data_dir]}"
  action :run
end


template "#{node[:postgresql_src][:data_dir]}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode "0600"
  # notifies :reload, "service[#{service_name}]"
  variables(connections: node[:postgresql_src][:connections],
            replication: node[:postgresql_src][:replication])
end


template "#{node[:postgresql_src][:data_dir]}/postgresql.conf" do
  source "postgresql.conf.erb"
  owner "postgres"
  group "postgres"
  mode "0600"
  variables(conf: node.set[:postgresql_src][:conf])
end

execute "postgres" do
  user "postgres"
  command "#{node[:postgresql_src][:bin_dir]}/postgres -D #{node[:postgresql_src][:data_dir]}"
  action :run
end



# template "#{data_dir}/postgresql.conf" do
#   source 'postgresql.conf.erb'
#   owner os_user
#   group os_group
#   mode '0600'
#   notifies :reload, "service[#{service_name}]"
#   variables config.to_hash.merge('listen_addresses' => node['postgres']['listen_addresses'])
# end






# include_recipe 'postgres::contrib'

# sudo mkdir /usr/local/pgsql/data
# sudo adduser postgres
# sudo chown postgres /usr/local/pgsql/data
# su - postgres
