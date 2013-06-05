
default['onddo-spamassassin']['conf']['rewrite_headers'] = [
  'Subject' => '[SPAM]',
]

default['onddo-spamassassin']['conf']['report_safe'] = true
default['onddo-spamassassin']['conf']['trusted_networks'] = nil
default['onddo-spamassassin']['conf']['lock_method'] = nil
default['onddo-spamassassin']['conf']['required_score'] = 5
default['onddo-spamassassin']['conf']['use_bayes'] = true
default['onddo-spamassassin']['conf']['bayes_auto_learn'] = true
default['onddo-spamassassin']['conf']['bayes_ignore_headers'] = []

default['onddo-spamassassin']['conf']['plugins']['shortcircuit'] = []

