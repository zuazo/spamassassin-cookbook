# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2014-2015 Onddo Labs, SL. (www.onddo.com)
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

describe 'onddo-spamassassin::default' do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  context 'with the old attribute namespace' do
    before do
      node.set['onddo-spamassassin']['conf']['required_score'] = 4
    end

    it 'prints the deprecated warning' do
      expect(Chef::Log).to receive(:warn).with(/DEPRECATED/)
      chef_run
    end

    it 'merges the old attribute namespace' do
      chef_run
      expect(node['spamassassin']['conf']['required_score']).to eq(4)
    end
  end

  it 'does not print the deprecated warning' do
    expect(Chef::Log).to_not receive(:warn).with(/DEPRECATED/)
    chef_run
  end

  it 'creates spamd user' do
    expect(chef_run).to create_user('spamd')
      .with_home('/var/lib/spamassassin')
      .with_shell('/bin/false')
      .with_system(true)
  end

  it 'creates spamd group' do
    expect(chef_run).to create_group('spamd')
      .with_members(%w(spamd))
      .with_system(true)
      .with_append(true)
  end

  it 'installs spamassassin package' do
    expect(chef_run).to install_package('spamassassin')
  end

  context 'on CentOS' do
    before do
      chef_runner.node.automatic['platform'] = 'centos'
      chef_runner.node.automatic['platform_version'] = '5.10'
    end

    it 'creates sysconfig/spamassassin file' do
      expect(chef_run).to create_template('/etc/sysconfig/spamassassin')
        .with_source('sysconfig_spamassassin.erb')
        .with_owner('root')
        .with_group('root')
        .with_mode('00644')
    end

    it 'sysconfig/spamassassin restarts spamassassin service' do
      resource = chef_run.template('/etc/sysconfig/spamassassin')
      expect(resource).to notify('service[spamassassin]').to(:restart).delayed
    end
  end # context on CentOS

  context 'on Ubuntu' do
    before do
      chef_runner.node.automatic['platform'] = 'ubuntu'
      chef_runner.node.automatic['platform_version'] = '12.04'
    end

    it 'creates default/spamassassin file' do
      expect(chef_run).to create_template('/etc/default/spamassassin')
        .with_source('default_spamassassin.erb')
        .with_owner('root')
        .with_group('root')
        .with_mode('00644')
    end

    it 'default/spamassassin restarts spamassassin service' do
      resource = chef_run.template('/etc/default/spamassassin')
      expect(resource).to notify('service[spamassassin]').to(:restart).delayed
    end
  end # context on Ubuntu

  it 'creates lib_path directory' do
    expect(chef_run).to create_directory('/var/lib/spamassassin')
      .with_owner('spamd')
      .with_group('spamd')
  end

  it 'lib_path directory runs fix-spamd-lib-owner' do
    resource = chef_run.directory('/var/lib/spamassassin')
    expect(resource).to notify('execute[fix-spamd-lib-owner]').to(:run)
      .immediately
  end

  it 'creates local.cf file' do
    expect(chef_run).to create_template('/etc/mail/spamassassin/local.cf')
      .with_source('local.cf.erb')
      .with_owner('root')
      .with_group('root')
      .with_mode('00644')
  end

  it 'local.cf restarts spamassassin service' do
    resource = chef_run.template('/etc/mail/spamassassin/local.cf')
    expect(resource).to notify('service[spamassassin]').to(:restart).delayed
  end

  it 'enables spamassassin service' do
    expect(chef_run).to enable_service('spamassassin')
      .with_supports(restart: true, reload: true, status: true)
  end

  it 'starts spamassassin service' do
    expect(chef_run).to start_service('spamassassin')
      .with_supports(restart: true, reload: true, status: true)
  end

  context 'on openSUSE' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'opensuse', version: '13.1')
    end

    it 'enables spamd service' do
      expect(chef_run).to enable_service('spamd')
        .with_supports(restart: true, reload: true, status: true)
    end

    it 'starts spamd service' do
      expect(chef_run).to start_service('spamd')
        .with_supports(restart: true, reload: true, status: true)
    end
  end
end
