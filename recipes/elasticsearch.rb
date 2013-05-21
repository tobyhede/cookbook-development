#
# Cookbook Name:: development
# Recipe:: elasticsearch

# node.set.java.remove_deprecated_packages = true
node.set.java.jdk_version = "7"
node.set.java.install_flavor = "openjdk"

node.set.elasticsearch.cluster_name = "test"
node.set.elasticsearch.mlockall = false

include_recipe "ubuntu::default"
include_recipe "java::default"
include_recipe "elasticsearch::default"
