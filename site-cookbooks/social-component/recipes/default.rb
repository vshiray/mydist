#
# Cookbook Name:: social-component
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'social-component' do
    supports :manage_home => true
    home '/home/social-component'
    shell '/bin/bash'
    action :create
end

directory '/opt/mydist/apps/social-component/run' do
    owner 'social-component'
    group 'social-component'
    mode '0755'
    action :create
end

directory '/opt/mydist/apps/social-component/log' do
    owner 'social-component'
    group 'social-component'
    mode '0755'
    action :create
end

template '/etc/init/social-component.conf' do
    variables({
        :appdir => '/opt/mydist/apps/social-component'
    })
    action :create
end
