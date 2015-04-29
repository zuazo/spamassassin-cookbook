Description
===========
[![Cookbook Version](https://img.shields.io/cookbook/v/onddo-spamassassin.svg?style=flat)](https://supermarket.chef.io/cookbooks/onddo-spamassassin)
[![Dependency Status](http://img.shields.io/gemnasium/onddo/spamassassin-cookbook.svg?style=flat)](https://gemnasium.com/onddo/spamassassin-cookbook)
[![Build Status](http://img.shields.io/travis/onddo/spamassassin-cookbook/1.0.0.svg?style=flat)](https://travis-ci.org/onddo/spamassassin-cookbook)

Installs and configures [SpamAssassin](http://spamassassin.apache.org/), a mail filter software to identify spam.

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon Linux
* CentOS
* Debian
* Fedora
* openSUSE
* RedHat
* SUSE
* Ubuntu

Please, [let us know](https://github.com/onddo/spamassassin-cookbook/issues/new?title=I%20have%20used%20it%20successfully%20on%20...) if you use it successfully on any other platform.

## Required Applications

* Ruby `>= 1.9.3`

Attributes
==========

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamc']['path']</code></td>
    <td>SpamAssassin client binary path</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['path']</code></td>
    <td>SpamAssassin daemon binary path</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['user']</code></td>
    <td>SpamAssassin user</td>
    <td><code>'spamd'</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['group']</code></td>
    <td>SpamAssassin group</td>
    <td><code>'spamd'</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['lib_path']</code></td>
    <td>SpamAssassin group</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['enabled']</code></td>
    <td>SpamAssassin daemon enabler flag</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['options']</code></td>
    <td>SpamAssassin daemon option arguments</td>
    <td><code>[<br/>
      &nbsp;&nbsp;'--create-prefs',<br/>
      &nbsp;&nbsp;'--max-children 5',<br/>
      &nbsp;&nbsp;'--helper-home-dir'<br/>
    ]</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['pidfile']</code></td>
    <td>SpamAssassin daemon pid file</td>
    <td><code>'/var/run/spamd.pid'</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['spamd']['nice']</code></td>
    <td>SpamAssassin daemon nice scheduling priority</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['rewrite_headers']</code></td>
    <td>An array of rewrite headers</td>
    <td><code>[<br/>
      &nbsp;&nbsp;{<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;'Subject' => '[SPAM]'<br/>
      &nbsp;&nbsp;}<br/>
    ]</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['report_safe']</code></td>
    <td>SpamAssassin report_safe enabler flag</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['trusted_networks']</code></td>
    <td>Network or hosts that are considered trusted</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['lock_method']</code></td>
    <td>File-locking method used to protect database files on-disk</td>
    <td><code>'flock'</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['required_score']</code></td>
    <td>Score required before a mail is considered spam</td>
    <td><code>5</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['use_bayes']</code></td>
    <td>Whether to use the naive-Bayesian-style classifier</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['bayes_auto_learn']</code></td>
    <td>Whether SpamAssassin should automatically feed high-scoring mail</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['bayes_ignore_headers']</code></td>
    <td>Headers ignored by the naive-Bayesian-style classifier</td>
    <td><code>[]</code></td>
  </tr>
  <tr>
    <td><code>node['spamassassin']['conf']['plugins']</code></td>
    <td>A hash to configure SpamAssassin plugins (<a href="#plugin-example">see the example below</a>)</td>
    <td><code>[]</code></td>
  </tr>
</table>

## plugin example

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
  "name": "mail.onddo.com",
  "[...]": "[...]",
  "run_list": [
    "recipe[onddo-spamassassin]"
  ]
}
```

Testing
=======

See [TESTING.md](https://github.com/onddo/spamassassin-cookbook/blob/master/TESTING.md).

Contributing
============

Please do not hesitate to [open an issue](https://github.com/onddo/spamassassin-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/onddo/spamassassin-cookbook/blob/master/CONTRIBUTING.md).

TODO
====

See [TODO.md](https://github.com/onddo/spamassassin-cookbook/blob/master/TODO.md).


License and Author
=====================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Xabier de Zuazo](https://github.com/zuazo) (<xabier@onddo.com>)
| **Copyright:**       | Copyright (c) 2013-2015 Onddo Labs, SL. (www.onddo.com)
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
