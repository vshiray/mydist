#
# Cookbook Name:: social-component
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "social-component" do
    supports :manage_home => true
    home '/home/social-component'
    shell '/bin/bash'
    action :create
end

template "/etc/init/social-component.conf" do
    variables({
        :appdir => '/opt/mydist/apps/social-component'
    })
    action :create
end

service 'social-component' do
    action [:start, :enable]
end
