#!/bin/sh

packer_file="template.json"
docker_image_name="com.example/packer-ansible-docker"
docker_image_tag="latest"

bake () {
    packer validate "$packer_file"
    packer build \
        -var "docker_image_name=$docker_image_name" \
        -var "docker_image_tag=$docker_image_tag" \
        "$packer_file"
}

test () {
    docker run --rm "$docker_image_name":"$docker_image_tag" neofetch
}

clean () {
    docker rmi $docker_image_name:$docker_image_tag
}

task=$1

case "$task" in
    bake | test | clean)
        $task
        ;;
    *)
        echo "./cli.sh [bake|test|clean]"
        ;;
esac
