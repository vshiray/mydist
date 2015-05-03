#
# Cookbook Name:: conceptus
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'conceptus' do
    supports :manage_home => true
    home '/home/conceptus'
    shell '/bin/bash'
    action :create
end

template '/etc/init/conceptus.conf' do
    variables({
        :appdir => '/opt/mydist/apps/conceptus'
    })
    action :create
end

service 'conceptus' do
    action [:start, :enable]
end
