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

package 'spamassassin'

case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then

  unless node['onddo-spamassassin']['spamd']['options'].include?('--daemonize')
    node.normal['onddo-spamassassin']['spamd']['options'] = node['onddo-spamassassin']['spamd']['options'] + [ '--daemonize' ]
  end

  template '/etc/sysconfig/spamassassin' do
    source 'sysconfig_spamassassin.erb'
    owner 'root'
    group 'root'
    mode '00644'
    variables(
      :options => node['onddo-spamassassin']['spamd']['options'],
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
      :options => node['onddo-spamassassin']['spamd']['options'],
      :pidfile => node['onddo-spamassassin']['spamd']['pidfile'],
      :nice => node['onddo-spamassassin']['spamd']['nice'],
      :cron => node['onddo-spamassassin']['spamd']['cron']
    )
    notifies :restart, 'service[spamassassin]'
  end

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

