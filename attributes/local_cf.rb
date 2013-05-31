
default['onddo-spamassassin']['conf']['rewrite_headers'] = [
  'Subject' => '[SPAM]',
]

default['onddo-spamassassin']['conf']['report_safe'] = true
default['onddo-spamassassin']['conf']['trusted_networks'] = nil
default['onddo-spamassassin']['conf']['lock_method'] = nil
default['onddo-spamassassin']['conf']['required_score'] = 5
default['onddo-spamassassin']['conf']['use_bayes'] = true
default['onddo-spamassassin']['conf']['bayes_auto_learn'] = true
default['onddo-spamassassin']['conf']['bayes_ignore_header'] = []

default['onddo-spamassassin']['conf']['plugins']['shortcircuit'] = []
# default['onddo-spamassassin']['conf']['plugins']['shortcircuit'] = [
#   {
#     'USER_IN_WHITELIST' => 'on',
#     'USER_IN_DEF_WHITELIST' => 'on',
#     'USER_IN_ALL_SPAM_TO' => 'on',
#     'SUBJECT_IN_WHITELIST' => 'on',
#
#     'USER_IN_BLACKLIST' => 'on',
#     'USER_IN_BLACKLIST_TO' => 'on',
#     'SUBJECT_IN_BLACKLIST' => 'on',
#
#     'ALL_TRUSTED' => 'on',
#
#     'BAYES_99' => 'spam',
#     'BAYES_00' => 'ham',
#   }
# ]

