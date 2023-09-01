#!/bin/sh

packer_file="template.pkr.hcl"
vagrant_box_name="com.example/packer-ansible-vagrant"

bake() {
  packer validate \
    -var "vagrant_box_name=$vagrant_box_name" \
    "$packer_file"

  packer build \
    -var "vagrant_box_name=$vagrant_box_name" \
    "$packer_file"
}

test() {
  vagrant box add --name "$vagrant_box_name" output-box/package.box
  vagrant up
  vagrant ssh --command "ansible --version"
  vagrant destroy --force
}

clean() {
  vagrant box remove "$vagrant_box_name"
  rm -rf output-box .vagrant
}

task="$1"

case "$task" in
bake | test | clean)
  "$task"
  ;;
*)
  echo "./cli.sh [bake|test|clean]"
  ;;
esac
