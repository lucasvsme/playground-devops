#!/bin/sh

packer_file="template.json"

bake () {
    packer validate "$packer_file"
    packer build "$packer_file"
}

bake
