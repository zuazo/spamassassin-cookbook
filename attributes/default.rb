
default['onddo-spamassassin']['spamc']['path'] = '/usr/bin/spamc'
default['onddo-spamassassin']['spamd']['path'] = '/usr/sbin/spamd'

# /etc/default/spamassassin
default['onddo-spamassassin']['spamd']['enabled'] = true
default['onddo-spamassassin']['spamd']['options'] = [
  '--create-prefs',
  '--max-children 5',
  '--helper-home-dir',
]
default['onddo-spamassassin']['spamd']['pidfile'] = '/var/run/spamd.pid'
default['onddo-spamassassin']['spamd']['nice'] = nil
default['onddo-spamassassin']['spamd']['cron'] = false

