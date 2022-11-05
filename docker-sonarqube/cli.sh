#!/bin/sh

pre_setup() {
    # SonarQube depends on Elasticsearch, which requires access
    # to more memory map areas a process may (defined by Linux)
    # This command changes the value to the one suggested.
    # https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
    sudo sysctl -w vm.max_map_count=262144
}

provision() {
    pre_setup
    docker-compose up --detach --force-recreate --renew-anon-volumes
}

post_destroy() {
    # Reverting command run in pre_setup function to the default value
    # Source: https://kernel.org/doc/Documentation/sysctl/vm.txt
    sudo sysctl -w vm.max_map_count=65536
}

destroy() {
    docker-compose down --volumes
    post_destroy
}


task="$1"

case "$task" in
provision | destroy)
    $task
    ;;
*)
    echo "./cli.sh [provision|destroy]"
    ;;
esac
