#
# Cookbook Name:: development
# Recipe:: postgresql_source

# http://ftp.postgresql.org/pub/source/v9.3beta1/postgresql-9.3beta1.tar.gz

default['postgres']['version']      = "9.3beta1"
default['postgres']['remote_tar']   = "http://ftp.postgresql.org/pub/source/v%VERSION%/postgresql-%VERSION%.tar.gz"
