#
# Cookbook Name:: fitnesse
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"

user "#{node[:fitnesse][:user]}" do
  comment "Runs Fitnesse"
  home "#{node[:fitnesse][:data_dir]}"
  shell "/bin/bash" 
end

[:program_dir, :data_dir].each do |key|
  directory "#{node[:fitnesse][key]}" do
    owner "#{node[:fitnesse][:user]}"
    mode "0755"
    action :create
  end
end

release_local = "#{node[:fitnesse][:program_dir]}/fitnesse_#{node[:fitnesse][:release]}.jar"
release_remote = "http://fitnesse.org/fitnesse.jar?responder=releaseDownload&release=#{node[:fitnesse][:release]}"

service "fitnesse" do
  provider Chef::Provider::Service::Upstart
  action :stop
end

remote_file release_local do
  source release_remote
  owner "#{node[:fitnesse][:user]}"
  mode "0644"
  action :create_if_missing
end

link "#{node[:fitnesse][:program_dir]}/fitnesse.jar" do
  to release_local
end

template "/etc/init/fitnesse.conf" do
  source "fitnesse.conf.erb"
end

service "fitnesse" do
  provider Chef::Provider::Service::Upstart
  action :start
end

