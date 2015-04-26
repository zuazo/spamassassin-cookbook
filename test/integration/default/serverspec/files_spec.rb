# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2015 Onddo Labs, SL. (www.onddo.com)
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

require 'spec_helper'

platform = os[:family].downcase

def has_runuser?
  system('which runuser')
end

service_config =
  if %w(suse).include?(platform)
    '/etc/sysconfig/spamd'
  elsif %w(redhat scientific fedora amazon).include?(platform)
    '/etc/sysconfig/spamassassin'
  elsif %w(debian ubuntu).include?(platform)
    '/etc/default/spamassassin'
  end

unless service_config.nil?
  describe file(service_config) do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by_user('spamd') } if has_runuser?
    it { should_not be_writable.by_user('spamd') } if has_runuser?
  end
end

describe file('/var/lib/spamassassin') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'spamd' }
  it { should be_grouped_into 'spamd' }
  it { should be_readable.by_user('spamd') } if has_runuser?
  it { should be_writable.by_user('spamd') } if has_runuser?
end

describe file('/etc/mail/spamassassin/local.cf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_readable.by_user('spamd') } if has_runuser?
  it { should_not be_writable.by_user('spamd') } if has_runuser?
end
