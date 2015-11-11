#
# Cookbook Name:: squidguard
# Recipe:: default
#
# Copyright 2015, Chris Cureau
#
# All rights reserved - Do Not Redistribute
#

require 'digest'

# Install packages for squidguard
package node['squidguard']['package']

# Configure packages
template node['squidguard']['config_file'] do
  source 'squidguard.conf.erb'
  user node['squidguard']['user']
  group node['squidguard']['group']
  mode '0640'
end

# Download the database if it has changed
remote_file "/tmp/#{node['squidguard']['blacklist_name']}" do
  source "#{node['squidguard']['blacklist_url']}"
  checksum node['squidguard']['blacklist_cksum']
  user node['squidguard']['user']
  group node['squidguard']['group']
  action :create
  notifies :run, 'ruby_block[generate_checksum]', :delayed
end

# Unpack database, generate checksum, delete temp file
ruby_block 'generate_checksum' do
  block do
    node.default['squidguard']['blacklist_cksum'] = Digest::SHA256.hexdigest File.read "/tmp/#{node['squidguard']['blacklist_name']}"
  end
  action :nothing
  notifies :run, 'bash[unpack_and_update]', :delayed
end

bash 'unpack_and_update' do
  code <<-EOH
    cd #{node['squidguard']['db_dir']}/
    tar xzf /tmp/#{node['squidguard']['blacklist_name']}
    mv ./#{node['squidguard']['blacklist_unpack']}/* .
    rmdir ./#{node['squidguard']['blacklist_unpack']}
    rm /tmp/#{node['squidguard']['blacklist_name']}
    squidGuard -C all
    chown -R #{node['squidguard']['user']}:#{node['squidguard']['group']} #{node['squidguard']['db_dir']}
    EOH
  action :nothing
  #notifies :restart, 'service[squid]', :delayed
end
