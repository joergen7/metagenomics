#
# Cookbook Name:: metagenomics
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.



mphm_dir = "#{node.dir.data}/mphm"
mphmrange = [*4457768..4459689, *4459691..4459735]

include_recipe "chef-bioinf-worker::qiime"
include_recipe "chef-cuneiform::default"

directory node.dir.wf
directory node.dir.data
directory node.dir.archive

# place workflow
template "#{node.dir.wf}/metagenomics.cf" do
  source "metagenomics.cf.erb"
end


# download data

directory mphm_dir

mphmrange.each { |id|
	
  url = "http://api.metagenomics.anl.gov/1/download/mgm#{id}.3?file=100.1"
  
  remote_file "#{mphm_dir}/mgm#{id}.fa" do
    action :create_if_missing
    source url
    retries 1
  end
  
}

# download greengenes otu reference

otu_link = "ftp://greengenes.microbio.me/greengenes_release/gg_13_5/gg_13_8_otus.tar.gz"
otu_tar  = "#{node.dir.archive}/#{File.basename( otu_link )}"
otu_dir  = "#{node.dir.data}/gg_13_8_otus"

remote_file otu_tar do
  action :create_if_missing
  source otu_link
  retries 1
end

bash "extract_otu" do
  code "tar xf #{otu_tar} -C #{node.dir.data}"
  not_if "#{Dir.exists?( otu_dir )}"
end
