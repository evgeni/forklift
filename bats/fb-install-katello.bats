#!/usr/bin/env bats
# vim: ft=sh:sw=2:et

set -o pipefail

load os_helper
load foreman_helper

setup() {
  tForemanSetLang
  tSetOSVersion
  FOREMAN_VERSION=$(tForemanVersion)
}

@test "stop puppet agent (if installed)" {
  tPackageExists "puppet" || skip "Puppet package not installed"
  tServiceStop puppet; tServiceDisable puppet
  true
}

@test "clean after puppet (if installed)" {
  [[ -d /var/lib/puppet/ssl ]] || skip "Puppet not installed, or SSL directory doesn't exist"
  rm -rf /var/lib/puppet/ssl
}

@test "make sure puppet not configured to other pm" {
  egrep -q "server\s*=" /etc/puppet/puppet.conf || skip "Puppet not installed, or 'server' not configured"
  sed -ir "s/^\s*server\s*=.*/server = $(hostname -f)/g" /etc/puppet/puppet.conf
}

@test "Zzzz.... (120 sec)" {
  sleep 120
}
