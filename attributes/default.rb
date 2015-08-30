# encoding: UTF-8
#
# Cookbook Name:: onddo-spamassassin
# Attributes:: default
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

default['spamassassin']['spamc']['path'] = '/usr/bin/spamc'

case node['platform_family']
when 'rhel'
  default['spamassassin']['spamd']['path'] = '/usr/bin/spamd'
  default['spamassassin']['spamd']['service_name'] = 'spamassassin'
  default['spamassassin']['spamd']['packages'] = %w(spamassassin)
when 'fedora'
  default['spamassassin']['spamd']['path'] = '/usr/bin/spamd'
  default['spamassassin']['spamd']['service_name'] = 'spamassassin'
  default['spamassassin']['spamd']['packages'] = %w(deltarpm spamassassin)
when 'suse'
  default['spamassassin']['spamd']['path'] = '/usr/sbin/spamd'
  default['spamassassin']['spamd']['service_name'] = 'spamd'
  default['spamassassin']['spamd']['packages'] = %w(spamassassin)
else
  default['spamassassin']['spamd']['path'] = '/usr/sbin/spamd'
  default['spamassassin']['spamd']['service_name'] = 'spamassassin'
  default['spamassassin']['spamd']['packages'] = %w(spamassassin spamc)
end

default['spamassassin']['spamd']['user'] = 'spamd'
default['spamassassin']['spamd']['group'] = 'spamd'
default['spamassassin']['spamd']['lib_path'] = '/var/lib/spamassassin'
default['spamassassin']['spamd']['enabled'] = true

# Config options for: /etc/default/spamassassin, /etc/sysconfig/spamassassin
default['spamassassin']['spamd']['options'] = [
  '--create-prefs',
  '--max-children 5',
  '--helper-home-dir'
]
default['spamassassin']['spamd']['pidfile'] = '/var/run/spamd.pid'
default['spamassassin']['spamd']['nice'] = nil
