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

service 'spamassassin' do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end

