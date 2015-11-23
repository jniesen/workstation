#!/usr/bin/env bash

set -ex

puppet_apply() {
  sudo puppet apply --modulepath=/etc/puppet/modules /etc/puppet/manifests/site.pp
}

main() {
  puppet_apply
}

main
