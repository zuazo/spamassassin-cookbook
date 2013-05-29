
default['onddo-spamassassin']['spamc']['path'] = '/usr/bin/spamc'
case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then
  default['onddo-spamassassin']['spamd']['path'] = '/usr/bin/spamd'
# when 'debian', 'ubuntu' then
else
  default['onddo-spamassassin']['spamd']['path'] = '/usr/sbin/spamd'
end

default['onddo-spamassassin']['spamd']['user'] = 'spamd'
default['onddo-spamassassin']['spamd']['group'] = 'spamd'
default['onddo-spamassassin']['spamd']['lib_path'] = '/var/lib/spamassassin'
default['onddo-spamassassin']['spamd']['enabled'] = true

#
# /etc/default/spamassassin, /etc/sysconfig/spamassassin
#

default['onddo-spamassassin']['spamd']['options'] = [
  '--create-prefs',
  '--max-children 5',
  '--helper-home-dir',
]
default['onddo-spamassassin']['spamd']['pidfile'] = '/var/run/spamd.pid'
default['onddo-spamassassin']['spamd']['nice'] = nil

