#!/usr/bin/env bats

@test 'spamc should be installed' {
  which spamc
}

@test 'spamd should be running' {
  ps axu | grep -q 'spam[d]'
}

@test 'should detect spam correctly' {
  [ -f /etc/fedora-release ] && skip # TODO: This does not work on Fedora :-/
  GTUBE='XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X'
  echo "${GTUBE}" | spamc | grep -qF 'X-Spam-Flag: YES'
}

