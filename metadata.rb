name             'onddo-spamassassin'
maintainer       'Onddo Labs, Sl.'
maintainer_email 'team@onddo.com'
license          'Apache 2.0'
description      'Installs and configures SpamAssassin, a mail filter software to identify spam.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'centos'
supports 'debian'
supports 'ubuntu'

recipe 'onddo-spamassassin::default', 'Installs SpamAssassin client and Daemon'

replaces 'spamassassin'

grouping 'onddo-spamassassin/spamc',
 :title => 'Spamd options',
 :description => 'SpamAssassin client options'

attribute 'onddo-spamassassin/spamc/path',
  :display_name => 'spamc path',
  :description => 'SpamAssassin client binary path',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

grouping 'onddo-spamassassin/spamd',
 :title => 'Spamd options',
 :description => 'SpamAssassin daemon options'

attribute 'onddo-spamassassin/spamd/path',
  :display_name => 'spamd path',
  :description => 'SpamAssassin daemon binary path',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

attribute 'onddo-spamassassin/spamd/user',
  :display_name => 'spamd user',
  :description => 'SpamAssassin user',
  :type => 'string',
  :required => 'optional',
  :default => '"spamd"'

attribute 'onddo-spamassassin/spamd/group',
  :display_name => 'spamd group',
  :description => 'SpamAssassin group',
  :type => 'string',
  :required => 'optional',
  :default => '"spamd"'

attribute 'onddo-spamassassin/spamd/lib_path',
  :display_name => 'spamd group',
  :description => 'SpamAssassin group',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

attribute 'onddo-spamassassin/spamd/enabled',
  :display_name => 'spamd enabled',
  :description => 'SpamAssassin daemon enabler flag',
  :choice => [ 'true', 'false' ],
  :type => 'string',
  :required => 'optional',
  :default => 'true'

attribute 'onddo-spamassassin/spamd/options',
  :display_name => 'spamd options',
  :description => 'SpamAssassin daemon option arguments',
  :type => 'array',
  :required => 'optional',
  :default => [
    '--create-prefs',
    '--max-children 5',
    '--helper-home-dir',
  ]

attribute 'onddo-spamassassin/spamd/pidfile',
  :display_name => 'spamd pidfile',
  :description => 'SpamAssassin daemon pid file',
  :type => 'string',
  :required => 'optional',
  :default => '"/var/run/spamd.pid"'

attribute 'onddo-spamassassin/spamd/nice',
  :display_name => 'spamd nice',
  :description => 'SpamAssassin daemon nice scheduling priority',
  :type => 'string',
  :required => 'optional',
  :default => nil

grouping 'onddo-spamassassin/conf',
 :title => 'Configuration options',
 :description => 'SpamAssassin configuration options (local.cf)'

attribute 'onddo-spamassassin/conf/rewrite_headers',
  :display_name => 'spam rewrite_headers',
  :description => 'An array of rewrite headers',
  :type => 'array',
  :required => 'recommended',
  :default => [
    'Subject' => '[SPAM]',
  ]

attribute 'onddo-spamassassin/conf/report_safe',
  :display_name => 'Report safe enabled',
  :description => 'SpamAssassin report_safe enabler flag',
  :choice => [ 'true', 'false', '0', '1', '2' ],
  :type => 'string',
  :required => 'optional',
  :default => 'true'

attribute 'onddo-spamassassin/conf/trusted_networks',
  :display_name => 'Trusted networks',
  :description => 'Network or hosts that are considered trusted',
  :type => 'string',
  :required => 'optional',
  :default => 'true'

attribute 'onddo-spamassassin/conf/lock_method',
  :display_name => 'File-lock method',
  :description => 'File-locking method used to protect database files on-disk',
  :choice => [ '"nfssafe"', '"flock"', '"win32"' ],
  :type => 'string',
  :required => 'optional',
  :default => '"flock"'

attribute 'onddo-spamassassin/conf/required_score',
  :display_name => 'Required score',
  :description => 'Score required before a mail is considered spam',
  :type => 'string',
  :required => 'recommended',
  :default => '5'

attribute 'onddo-spamassassin/conf/use_bayes',
  :display_name => 'Use bayes',
  :description => 'Whether to use the naive-Bayesian-style classifier',
  :type => 'string',
  :required => 'optional',
  :default => 'true'

attribute 'onddo-spamassassin/conf/bayes_auto_learn',
  :display_name => 'Use bayes',
  :description => 'Whether SpamAssassin should automatically feed high-scoring mail',
  :type => 'string',
  :required => 'optional',
  :default => 'true'

attribute 'onddo-spamassassin/conf/bayes_ignore_headers',
  :display_name => 'Bayes ignore headers',
  :description => 'Headers ignored by the naive-Bayesian-style classifier',
  :type => 'array',
  :required => 'optional',
  :default => []

attribute 'onddo-spamassassin/conf/plugins',
  :display_name => 'plugins',
  :description => 'A hash to configure SpamAssassin plugins',
  :type => 'array',
  :required => 'optional',
  :default => []

