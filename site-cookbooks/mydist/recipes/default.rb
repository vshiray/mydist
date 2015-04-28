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
end
