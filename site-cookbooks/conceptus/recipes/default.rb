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

directory '/opt/mydist/apps/conceptus/run' do
    owner 'conceptus'
    group 'conceptus'
    mode '0755'
    action :create
end

directory '/opt/mydist/apps/conceptus/log' do
    owner 'conceptus'
    group 'conceptus'
    mode '0755'
    action :create
end

template '/etc/init/conceptus.conf' do
    variables({
        :appdir => '/opt/mydist/apps/conceptus'
    })
    action :create
end
