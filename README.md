SpamAssassin Cookbook
=====================
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg?style=flat)](http://www.rubydoc.info/github/zuazo/spamassassin-cookbook)
[![GitHub](http://img.shields.io/badge/github-zuazo/spamassassin--cookbook-blue.svg?style=flat)](https://github.com/zuazo/spamassassin-cookbook)
[![License](https://img.shields.io/github/license/zuazo/spamassassin-cookbook.svg?style=flat)](#license-and-author)

[![Cookbook Version](https://img.shields.io/cookbook/v/onddo-spamassassin.svg?style=flat)](https://supermarket.chef.io/cookbooks/onddo-spamassassin)
[![Dependency Status](http://img.shields.io/gemnasium/zuazo/spamassassin-cookbook.svg?style=flat)](https://gemnasium.com/zuazo/spamassassin-cookbook)
[![Code Climate](http://img.shields.io/codeclimate/github/zuazo/spamassassin-cookbook.svg?style=flat)](https://codeclimate.com/github/zuazo/spamassassin-cookbook)
[![Build Status](http://img.shields.io/travis/zuazo/spamassassin-cookbook/2.0.0.svg?style=flat)](https://travis-ci.org/zuazo/spamassassin-cookbook)
[![Coverage Status](http://img.shields.io/coveralls/zuazo/spamassassin-cookbook/2.0.0.svg?style=flat)](https://coveralls.io/r/zuazo/spamassassin-cookbook?branch=2.0.0)
[![Inline docs](http://inch-ci.org/github/zuazo/spamassassin-cookbook.svg?branch=master&style=flat)](http://inch-ci.org/github/zuazo/spamassassin-cookbook)

[Chef](https://www.chef.io/) cookbook to install and configure [SpamAssassin](http://spamassassin.apache.org/), a mail filter software to identify spam.

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon Linux
* CentOS
* Debian
* Fedora
* openSUSE
* Oracle Linux
* RedHat
* SUSE
* Ubuntu

Please, [let us know](https://github.com/zuazo/spamassassin-cookbook/issues/new?title=I%20have%20used%20it%20successfully%20on%20...) if you use it successfully on any other platform.

## Required Applications

* Chef `12` or higher.
* Ruby `2.2` or higher.

Attributes
==========

| Attribute                                              | Default                | Description                    |
|:-------------------------------------------------------|:-----------------------|:-------------------------------|
| `node['spamassassin']['spamc']['path']`                | *calculated*           | SpamAssassin client binary path.
| `node['spamassassin']['spamd']['path']`                | *calculated*           | SpamAssassin daemon binary path.
| `node['spamassassin']['spamd']['user']`                | `'spamd'`              | SpamAssassin user.
| `node['spamassassin']['spamd']['group']`               | `'spamd'`              | SpamAssassin group.
| `node['spamassassin']['spamd']['lib_path']`            | *calculated*           | SpamAssassin library path.
| `node['spamassassin']['spamd']['enabled']`             | `true`                 | SpamAssassin daemon enabler flag.
| `node['spamassassin']['spamd']['options']`             | *calculated*           | SpamAssassin daemon option arguments.
| `node['spamassassin']['spamd']['pidfile']`             | `'/var/run/spamd.pid'` | SpamAssassin daemon pid file.
| `node['spamassassin']['spamd']['nice']`                | `nil`                  | SpamAssassin daemon nice scheduling priority.
| `node['spamassassin']['conf']['rewrite_headers']`      | *calculated*           | An array of rewrite headers.
| `node['spamassassin']['conf']['report_safe']`          | `true`                 | SpamAssassin report_safe enabler flag.
| `node['spamassassin']['conf']['trusted_networks']`     | `nil`                  | Network or hosts that are considered trusted.
| `node['spamassassin']['conf']['lock_method']`          | `'flock'`              | File-locking method used to protect database files on-disk.
| `node['spamassassin']['conf']['required_score']`       | `5`                    | Score required before a mail is considered spam.
| `node['spamassassin']['conf']['use_bayes']`            | `true`                 | Whether to use the naive-Bayesian-style classifier.
| `node['spamassassin']['conf']['bayes_auto_learn']`     | `true`                 | Whether SpamAssassin should automatically feed high-scoring mail.
| `node['spamassassin']['conf']['bayes_ignore_headers']` | `[]`                   | Headers ignored by the naive-Bayesian-style classifier.
| `node['spamassassin']['conf']['plugins']`              | `[]`                   | A hash to configure SpamAssassin plugins ([see the example below](#plugin-example)).

## Plugin Example

```ruby
node.default['spamassassin']['conf']['plugins']['shortcircuit'] = [
  {
    'USER_IN_WHITELIST' => 'on',
    'USER_IN_DEF_WHITELIST' => 'on',
    'USER_IN_ALL_SPAM_TO' => 'on',
    'SUBJECT_IN_WHITELIST' => 'on',

    'USER_IN_BLACKLIST' => 'on',
    'USER_IN_BLACKLIST_TO' => 'on',
    'SUBJECT_IN_BLACKLIST' => 'on',

    'ALL_TRUSTED' => 'on',

    'BAYES_99' => 'spam',
    'BAYES_00' => 'ham'
  }
]
```

Recipes
=======

## onddo-spamassassin::default

Installs SpamAssassin client and Daemon.

Usage Examples
==============

## Including in a Cookbook Recipe

Running it from a recipe:

```ruby
# Required_score is set to 5 by default, change it:
node.default['spamassassin']['conf']['required_score'] = 4
include_recipe 'onddo-spamassassin::default' # or include it in your run-list
```

Don't forget to include the `onddo-spamassassin` cookbook as a dependency in the metadata.

```ruby
# metadata.rb
# [...]

depends 'onddo-spamassassin'
```

## Including in the Run List

Another alternative is to include the default recipe in your *Run List*.

```json
{
  "name": "mail.example.com",
  "[...]": "[...]",
  "run_list": [
    "recipe[onddo-spamassassin]"
  ]
}
```

Testing
=======

See [TESTING.md](https://github.com/zuazo/spamassassin-cookbook/blob/master/TESTING.md).

Contributing
============

Please do not hesitate to [open an issue](https://github.com/zuazo/spamassassin-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/zuazo/spamassassin-cookbook/blob/master/CONTRIBUTING.md).

TODO
====

See [TODO.md](https://github.com/zuazo/spamassassin-cookbook/blob/master/TODO.md).


License and Author
=====================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Xabier de Zuazo](https://github.com/zuazo) (<xabier@zuazo.org>)
| **Copyright:**       | Copyright (c) 2015, Xabier de Zuazo
| **Copyright:**       | Copyright (c) 2013-2015 Onddo Labs, SL.
| **License:**         | Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
