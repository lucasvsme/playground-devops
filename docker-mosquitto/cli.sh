#!/bin/sh

provision() {
    docker-compose up --detach --force-recreate --renew-anon-volumes
}

destroy() {
    docker-compose down --volumes
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
