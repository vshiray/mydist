#
# Cookbook Name:: nginx-dist
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

apt_repository 'nginx' do
  uri           'http://nginx.org/packages/ubuntu/'
  distribution  node['lsb']['codename']
  components    ['nginx']
  key           'http://nginx.org/keys/nginx_signing.key'
end

package 'nginx'

service 'nginx' do
    action [:enable, :start]
end
