#
# Cookbook Name:: onddo-spamassassin
# Recipe:: default
#
# Copyright 2013, Onddo Labs, Sl.
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

user node['onddo-spamassassin']['spamd']['user'] do
  comment 'SpamAssassin Daemon'
  home node['onddo-spamassassin']['spamd']['lib_path']
  shell '/bin/false'
  system true
end

group node['onddo-spamassassin']['spamd']['group'] do
  members [ node['onddo-spamassassin']['spamd']['user'] ]
  system true
  append true
end

node.default['onddo-spamassassin']['spamd']['options'] = node['onddo-spamassassin']['spamd']['options'] + [
  "--username=#{node['onddo-spamassassin']['spamd']['user']}",
  "--groupname=#{node['onddo-spamassassin']['spamd']['group']}",
]

execute 'sa-update' do
  case node['platform']
  when 'debian', 'ubuntu'
    command "sa-update --gpghomedir #{node['onddo-spamassassin']['spamd']['lib_path']}/sa-update-keys"
  else
    command 'sa-update --no-gpg'
  end
  action :nothing
  notifies :restart, 'service[spamassassin]'
end

package 'spamassassin' do
  notifies :run, 'execute[sa-update]'
end

options = node['onddo-spamassassin']['spamd']['options']

case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then

  unless options.include?('--daemonize')
    options = options + [ '--daemonize' ]
  end

  template '/etc/sysconfig/spamassassin' do
    source 'sysconfig_spamassassin.erb'
    owner 'root'
    group 'root'
    mode '00644'
    variables(
      :options => options,
      :pidfile => node['onddo-spamassassin']['spamd']['pidfile'],
      :nice => node['onddo-spamassassin']['spamd']['nice']
    )
    notifies :restart, 'service[spamassassin]'
  end

when 'debian', 'ubuntu'
  package 'spamc'

  template '/etc/default/spamassassin' do
    source 'default_spamassassin.erb'
    owner 'root'
    group 'root'
    mode '00644'
    variables(
      :enabled => node['onddo-spamassassin']['spamd']['enabled'],
      :options => options,
      :pidfile => node['onddo-spamassassin']['spamd']['pidfile'],
      :nice => node['onddo-spamassassin']['spamd']['nice']
    )
    notifies :restart, 'service[spamassassin]'
  end

end

execute 'fix-spamd-lib-owner' do
  command "chown -R '#{node['onddo-spamassassin']['spamd']['user']}:#{node['onddo-spamassassin']['spamd']['group']}' '#{node['onddo-spamassassin']['spamd']['lib_path']}'"
  action :nothing
end

directory node['onddo-spamassassin']['spamd']['lib_path'] do
  owner node['onddo-spamassassin']['spamd']['user']
  group node['onddo-spamassassin']['spamd']['group']
  notifies :run, 'execute[fix-spamd-lib-owner]', :immediately
end

template '/etc/mail/spamassassin/local.cf' do
  source 'local.cf.erb'
  owner 'root'
  group 'root'
  mode '00644'
  variables(
    :conf => node['onddo-spamassassin']['conf']
  )
  notifies :restart, 'service[spamassassin]'
end

if node['onddo-spamassassin']['spamd']['enabled']
  service 'spamassassin' do
    supports :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
  end
else
  service 'spamassassin' do
    supports :restart => true, :reload => false, :status => true
    action [ :disable, :stop ]
  end
end

