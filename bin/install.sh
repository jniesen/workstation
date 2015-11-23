#!/usr/bin/env bash

set -ex

readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ROOTDIR=$PROGDIR/..
readonly PUPPET_HOME=/etc/puppet

is_dir() {
  local file=$1

  [[ -d $file ]]
}

match_symlink() {
  local file=$1
  local target=$ROOTDIR/$file
  local link_name=$PUPPET_HOME/$file

  is_dir $link_name \
    && sudo rm -rf $link_name

  sudo ln -s $target $link_name
}

add_puppet_symlinks() {
  local puppet_files=$@

  for file in $puppet_files
  do
    match_symlink $file
  done
}

first_puppet_run() {
  $PROGDIR/apply.sh
}

main() {
  add_puppet_symlinks \
    manifests \
    modules

  first_puppet_run
}

main
