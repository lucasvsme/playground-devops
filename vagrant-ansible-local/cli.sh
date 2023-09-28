#!/bin/sh

provision() {
  vagrant up --provision
}

destroy() {
  vagrant destroy
}

task="$1"

case "$task" in
provision | destroy)
  "$task"
  ;;
*)
  echo "./cli.sh [provision|destroy]"
  ;;
esac
