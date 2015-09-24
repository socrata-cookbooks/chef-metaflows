#
# Cookbook Name:: chef-metaflows
# Recipe:: default
# cookbook to distribute the metaflows agent
# 

include_recipe 'runit'

package 'nmap'

if node['metaflows'] && node['metaflows']['sensor_ip']
  runit_service 'metaflows' do 
    options(sensor_ip: node['metaflows']['sensor_ip'])
    action :enable
  end
end
