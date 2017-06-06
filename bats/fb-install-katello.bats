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

@test "Zzzz.... (120 sec)" {
  sleep 120
}
