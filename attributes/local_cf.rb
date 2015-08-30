# encoding: UTF-8
#
# Cookbook Name:: onddo-spamassassin
# Attributes:: local_cf
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

default['spamassassin']['conf']['rewrite_headers'] = [
  'Subject' => '[SPAM]'
]

default['spamassassin']['conf']['report_safe'] = true
default['spamassassin']['conf']['trusted_networks'] = nil
default['spamassassin']['conf']['lock_method'] = nil
default['spamassassin']['conf']['required_score'] = 5
default['spamassassin']['conf']['use_bayes'] = true
default['spamassassin']['conf']['bayes_auto_learn'] = true
default['spamassassin']['conf']['bayes_ignore_headers'] = []

default['spamassassin']['conf']['plugins']['shortcircuit'] = []
