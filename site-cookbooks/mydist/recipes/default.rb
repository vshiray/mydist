#
# Cookbook Name:: mydist
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

myips=[]

node['network']['interfaces'].each_value do |i|
    i['addresses'].each do |a,v|
        myips.push(a) if v['family'] == 'inet'
    end
end

if myips.include?(node['mydist']['postgresql']['host'])
    pg_hba = []
    pg_hba.push({"type" => "local", "db" => "postgres", "user" => "postgres", "addr" => "", "method" => "peer"})
    pg_hba.push({"type" => "local", "db" => "all", "user" => "all", "addr" => "", "method" => "md5"})
    pg_hba.push({"type" => "host",  "db" => "all", "user" => "all", "addr" => "0.0.0.0/0", "method" => "md5"})

    node.default['postgresql']['version'] = '9.4'
    node.default['postgresql']['listen_addresses'] = '0.0.0.0'
    node.default['postgresql']['pg_hba'] = pg_hba
    include_recipe 'postgresql::server'
else
    service "postgresql" do
        action [:stop, :disable]
    end
end

if myips.include?(node['mydist']['mongodb']['host'])
    include_recipe 'mongodb'
else
    service "mongodb" do
        action [:stop, :disable]
    end
end

if myips.include?(node['mydist']['nginx']['host'])
    include_recipe 'nginx-dist'
else
    service "nginx" do
        action [:stop, :disable]
    end
end

if myips.include?(node['mydist']['social']['host']) || myips.include?(node['mydist']['conceptus']['host'])
    node.default['java']['install_flavor'] = 'oracle'
    node.default['java']['jdk_version'] = '8'
    node.default['java']['oracle']['accept_license_agreement'] = 'true'
    node.default['java']['oracle']['accept_oracle_download_terms'] = 'true'
    include_recipe 'java'
end

if myips.include?(node['mydist']['social']['host'])
    include_recipe 'xvfb::package'
    include_recipe 'chrome'

    package 'unzip'
    remote_file "#{Chef::Config[:file_cache_path]}/chromedriver_linux64.zip" do
        action :create_if_missing
        source "http://chromedriver.storage.googleapis.com/2.15/chromedriver_linux64.zip"
    end
    execute "Install Crome Driver" do
        command "unzip '#{Chef::Config[:file_cache_path]}/chromedriver_linux64.zip' -d /usr/local/bin; chmod 755 /usr/local/bin/chromedriver"
        not_if { ::File.exists?("/usr/local/bin/chromedriver")}
    end
end
