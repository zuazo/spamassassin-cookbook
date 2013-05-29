
# /etc/default/spamassassin
default['onddo-spamassassin']['enabled'] = true
default['onddo-spamassassin']['options'] = [
  '--create-prefs',
  '--max-children 5',
  '--helper-home-dir',
]
default['onddo-spamassassin']['pidfile'] = '/var/run/spamd.pid'
default['onddo-spamassassin']['nice'] = nil
default['onddo-spamassassin']['cron'] = false

