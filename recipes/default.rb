#
# Cookbook Name:: metagenomics
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

mphm_dir = "#{node.dir.data}/mphm"


directory node.dir.wf
directory node.dir.data

# place workflow
template "#{node.dir.wf}/metagenomics.cf" do
  source "metagenomics.cf.erb"
end


# download data

directory mphm_dir

node.data.mphmrange.each { |id|
	
  if id == 4459690 then
    next
  end

  url = "http://api.metagenomics.anl.gov/1/download/mgm#{id}.3"
  
  remote_file "#{mphm_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
  
}
