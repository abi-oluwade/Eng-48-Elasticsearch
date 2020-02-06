#
# Cookbook:: elk_stack
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

apt_update 'update ubuntu' do
  action :update
end

# Install java
package "libxt-dev" do
  action :install
end

apt_package 'openjdk-8-jdk' do
  action :install
end

# Installing https transport package
package "apt-transport-https" do
  action :install
end

elasticsearch_user 'elasticsearch' do
  action :nothing
end

elasticsearch_install 'elasticsearch' do
  type :package
end


service 'elasticsearch' do
  action [:enable, :start]
end

file ("/etc/elasticsearch/elasticsearch.yml") do
  action :delete
end

file ("/etc/elasticsearch/jvm.options") do
  action :delete
end

template ("/etc/elasticsearch/elasticsearch.yml") do
  source 'elasticsearch.yml.erb'
end

template ("/etc/elasticsearch/jvm.options") do
  source "jvm.options.erb"
end
