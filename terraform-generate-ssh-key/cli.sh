#!/bin/sh

provision() {
  terraform init
  terraform validate
  terraform apply -auto-approve
}

destroy() {
  terraform destroy -auto-approve
}

task=$1

case "$task" in
provision | destroy)
  $task
  ;;
*)
  echo "./cli.sh [provision|destroy]"
  ;;
esac
