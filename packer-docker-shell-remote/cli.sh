#!/bin/sh

packer_file="template.pkr.hcl"

bake() {
  packer validate "$packer_file"
  packer build "$packer_file"
}

task="$1"

case "$task" in
bake)
  "$task"
  ;;
*)
  echo "./cli.sh [bake]"
  ;;
esac
