# encoding: UTF-8
#
# Cookbook Name:: onddo-spamassassin
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

name 'onddo-spamassassin'
maintainer 'Xabier de Zuazo'
maintainer_email 'xabier@zuazo.org'
license 'Apache 2.0'
description <<-EOH
Installs and configures SpamAssassin, a mail filter software to identify spam.
EOH
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'

if respond_to?(:source_url)
  source_url 'https://github.com/zuazo/spamassassin-cookbook'
end
if respond_to?(:issues_url)
  issues_url 'https://github.com/zuazo/spamassassin-cookbook/issues'
end

chef_version '>= 12' if respond_to?(:chef_version)

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'opensuse'
supports 'oracle'
supports 'redhat'
supports 'suse'
supports 'ubuntu'

recipe 'onddo-spamassassin::default', 'Installs SpamAssassin client and Daemon'

attribute 'spamassassin/spamc/path',
          display_name: 'spamc path',
          description: 'SpamAssassin client binary path',
          calculated: true,
          type: 'string',
          required: 'optional'

attribute 'spamassassin/spamd/path',
          display_name: 'spamd path',
          description: 'SpamAssassin daemon binary path',
          calculated: true,
          type: 'string',
          required: 'optional'

attribute 'spamassassin/spamd/user',
          display_name: 'spamd user',
          description: 'SpamAssassin user',
          type: 'string',
          required: 'optional',
          default: 'spamd'

attribute 'spamassassin/spamd/group',
          display_name: 'spamd group',
          description: 'SpamAssassin group',
          type: 'string',
          required: 'optional',
          default: 'spamd'

attribute 'spamassassin/spamd/lib_path',
          display_name: 'spamd group',
          description: 'SpamAssassin group',
          calculated: true,
          type: 'string',
          required: 'optional'

attribute 'spamassassin/spamd/enabled',
          display_name: 'spamd enabled',
          description: 'SpamAssassin daemon enabler flag',
          choice: %w(true false),
          type: 'string',
          required: 'optional',
          default: true

attribute 'spamassassin/spamd/options',
          display_name: 'spamd options',
          description: 'SpamAssassin daemon option arguments',
          type: 'array',
          required: 'optional',
          default: [
            '--create-prefs',
            '--max-children 5',
            '--helper-home-dir'
          ]

attribute 'spamassassin/spamd/pidfile',
          display_name: 'spamd pidfile',
          description: 'SpamAssassin daemon pid file',
          type: 'string',
          required: 'optional',
          default: '/var/run/spamd.pid'

attribute 'spamassassin/spamd/nice',
          display_name: 'spamd nice',
          description: 'SpamAssassin daemon nice scheduling priority',
          type: 'string',
          required: 'optional',
          default: 'nil'

attribute 'spamassassin/conf/rewrite_headers',
          display_name: 'spam rewrite_headers',
          description: 'An array of rewrite headers',
          type: 'array',
          required: 'recommended',
          default: [
            'Subject' => '[SPAM]'
          ]

attribute 'spamassassin/conf/report_safe',
          display_name: 'Report safe enabled',
          description: 'SpamAssassin report_safe enabler flag',
          choice: %w(true false 0 1 2),
          type: 'string',
          required: 'optional',
          default: true

attribute 'spamassassin/conf/trusted_networks',
          display_name: 'Trusted networks',
          description: 'Network or hosts that are considered trusted',
          type: 'string',
          required: 'optional',
          default: 'nil'

attribute 'spamassassin/conf/lock_method',
          display_name: 'File-lock method',
          description:
            'File-locking method used to protect database files on-disk',
          choice: %w(nfssafe flock win32),
          type: 'string',
          required: 'optional',
          default: 'flock'

attribute 'spamassassin/conf/required_score',
          display_name: 'Required score',
          description: 'Score required before a mail is considered spam',
          type: 'string',
          required: 'recommended',
          default: '5'

attribute 'spamassassin/conf/use_bayes',
          display_name: 'Use bayes',
          description: 'Whether to use the naive-Bayesian-style classifier',
          choice: %w(true false),
          type: 'string',
          required: 'optional',
          default: true

attribute 'spamassassin/conf/bayes_auto_learn',
          display_name: 'Use bayes',
          description:
            'Whether SpamAssassin should automatically feed high-scoring mail',
          choice: %w(true false),
          type: 'string',
          required: 'optional',
          default: true

attribute 'spamassassin/conf/bayes_ignore_headers',
          display_name: 'Bayes ignore headers',
          description:
            'Headers ignored by the naive-Bayesian-style classifier',
          type: 'array',
          required: 'optional',
          default: []

attribute 'spamassassin/conf/plugins',
          display_name: 'plugins',
          description: 'A hash to configure SpamAssassin plugins',
          type: 'array',
          required: 'optional',
          default: []
