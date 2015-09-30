# install and run the metaflows sensor/collector
include_recipe 'runit'

if node['platform'] == 'centos'
  package 'expect'
  package 'expectk'

  cookbook_file "/etc/chef/register_sensor" do
    source 'register_sensor'
    owner 'metaflows'
    group 'metaflows'
    mode '0755'
    action :create_if_missing
  end

  socrata_configuration_kms "s3://#{node['metaflows']['clortho_bucket']}/#{node['metaflows']['metaflows_clortho_file']}" do
    local_path "/dev/shm/#{node['metaflows']['metaflows_clortho_file']}"
    owner "metaflows"
    group "metaflows"
    mode 0600
    region node['cloud']['region']
    notifies :run, 'bash[register sensor]', :immediately
  end

  sensor_status = File.open("/nsm/etc/UUID", &:readline)

  # overwrite the tty requirement in CentOS so we can run scripts with scripts and sudo
  # an expect script will answer the prompt and register the sensor
  bash 'register sensor' do
    code <<-EOC
    set -e
    sed -i '/Defaults    requiretty/c\# Defaults    requiretty' /etc/sudoers
    sed -i '/Defaults   !visiblepw/c\# Defaults   !visiblepw' /etc/sudoers
    source /dev/shm/#{node['metaflows']['metaflows_clortho_file']}
    /etc/chef/register_sensor
    EOC
    action :nothing
    environment({ 'CHEF_ENV' => node.chef_environment })
    notifies :restart, 'runit_service[mss]', :delayed
    only_if { sensor_status.include?("export sid=0\n") }
  end

  if mss_config = node['metaflows']['config']
    ruby_block 'configure mss' do
      block do
        fe = Chef::Util::FileEdit.new(node['metaflows']['config_file'])
        mss_config.each do |conf_key,conf_value|
          cfg_line = "export #{conf_key}=#{conf_value}"
          fe.search_file_replace_line(/^export #{conf_key}=/, cfg_line)
          fe.insert_line_if_no_match(/^export #{conf_key}=/, cfg_line)
        end
        fe.write_file
      end
      notifies :restart, 'runit_service[mss]', :delayed
      only_if { File.exists?(node['metaflows']['config_file']) }
    end
  end
  runit_service 'mss' do
    action :enable
  end
end
