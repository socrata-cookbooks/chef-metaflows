# install and run the metaflows sensor/collector
# the software currently only runs on centos

if node['platform'] == 'centos'
  bash 'install metaflows sensor' do 
    code <<-EOC
      curl -O http://http://nsm.metaflows.com/updates/nsm_remote.zip
      unzip nsm_remote.zip
      cd nsm_remote
      ./install_collector.sh
      /nsm/etc/mss_collector.sh start
      EOC
    not_if { ::File.exists?('/nsm/etc/mss_collector.sh')
  end
end
