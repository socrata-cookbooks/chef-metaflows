#
# Cookbook:: chef-metaflows
# Recipe:: agent
# recipe to distribute the metaflows agent
#

include_recipe 'runit'

package 'ncat'
package 'tcpdump'

if node['metaflows'] && node['metaflows']['sensor_ip']
  runit_service 'metaflows' do
    options(sensor_ip: node['metaflows']['sensor_ip'])
    action :enable
  end
end
