# encoding: UTF-8
#
# Cookbook Name:: onddo-spamassassin
# Recipe:: default
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2013-2015 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Attribute namespace backwards compatible
unless node['onddo-spamassassin'].nil?
  Chef::Log.warn(
    '[DEPRECATED] Use `node["spamassassin"]` namespace with the '\
    'onddo-spamassassin cookbook instead of the old `node["spamassassin"]` '\
    'namespace.'
  )
  node.default['spamassassin'] =
    Chef::Mixin::DeepMerge.hash_only_merge(
      node['spamassassin'], node['onddo-spamassassin']
    )
end

service_name = node['spamassassin']['spamd']['service_name']

user node['spamassassin']['spamd']['user'] do
  comment 'SpamAssassin Daemon'
  home node['spamassassin']['spamd']['lib_path']
  shell '/bin/false'
  system true
end

group node['spamassassin']['spamd']['group'] do
  members [node['spamassassin']['spamd']['user']]
  system true
  append true
end

node.default['spamassassin']['spamd']['options'] =
  node['spamassassin']['spamd']['options'] +
  [
    "--username=#{node['spamassassin']['spamd']['user']}",
    "--groupname=#{node['spamassassin']['spamd']['group']}"
  ]

execute 'sa-update' do
  case node['platform_family']
  when 'debian'
    command(
      format(
        "sa-update --gpghomedir '%<lib_path>s/sa-update-keys'",
        lib_path: node['spamassassin']['spamd']['lib_path']
      )
    )
  else
    command 'sa-update --no-gpg'
  end
  action :nothing
  notifies :restart, "service[#{service_name}]"
end

node['spamassassin']['spamd']['packages'].each do |pkg|
  package pkg do
    notifies :run, 'execute[sa-update]'
  end
end

options = node['spamassassin']['spamd']['options']

case node['platform_family']
when 'suse'
  template '/etc/sysconfig/spamd' do
    source 'sysconfig_spamassassin.erb'
    owner 'root'
    group 'root'
    mode '00644'
    variables(
      options: options
    )
    notifies :restart, "service[#{service_name}]"
  end
when 'fedora', 'rhel'
  template '/etc/sysconfig/spamassassin' do
    source 'sysconfig_spamassassin.erb'
    owner 'root'
    group 'root'
    mode '00644'
    variables(
      options: options,
      pidfile: node['spamassassin']['spamd']['pidfile'],
      nice: node['spamassassin']['spamd']['nice']
    )
    notifies :restart, "service[#{service_name}]"
  end
when 'debian'
  template '/etc/default/spamassassin' do
    source 'default_spamassassin.erb'
    owner 'root'
    group 'root'
    mode '00644'
    variables(
      enabled: node['spamassassin']['spamd']['enabled'],
      options: options,
      pidfile: node['spamassassin']['spamd']['pidfile'],
      nice: node['spamassassin']['spamd']['nice']
    )
    notifies :restart, "service[#{service_name}]"
  end
end

execute 'fix-spamd-lib-owner' do
  command(
    format(
      "chown -R '%<user>s:%<group>s' '%<path>s'",
      user: node['spamassassin']['spamd']['user'],
      group: node['spamassassin']['spamd']['group'],
      path: node['spamassassin']['spamd']['lib_path']
    )
  )
  action :nothing
end

directory node['spamassassin']['spamd']['lib_path'] do
  owner node['spamassassin']['spamd']['user']
  group node['spamassassin']['spamd']['group']
  notifies :run, 'execute[fix-spamd-lib-owner]', :immediately
end

template '/etc/mail/spamassassin/local.cf' do
  source 'local.cf.erb'
  owner 'root'
  group 'root'
  mode '00644'
  variables(
    conf: node['spamassassin']['conf']
  )
  notifies :restart, "service[#{service_name}]"
end

if node['spamassassin']['spamd']['enabled']
  service service_name do
    supports restart: true, reload: true, status: true
    action [:enable, :start]
  end
else
  service service_name do
    supports restart: true, reload: false, status: true
    action [:disable, :stop]
  end
end
