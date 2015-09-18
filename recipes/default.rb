#
# Cookbook Name:: metagenomics
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


directory node.dir.wf
directory node.dir.data

# place workflow
template "#{node.dir.wf}/metagenomics.cf" do
  source "metagenomics.cf.erb"
end

