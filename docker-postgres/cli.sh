#!/bin/sh

provision() {
    docker-compose up --detach --force-recreate --renew-anon-volumes
}

destroy() {
    docker-compose down --volumes
}

enter() {
    container_name="docker-postgres-database-1"

    docker exec --interactive --tty "$container_name" \
        psql postgresql://user:password@localhost:5432
}

task="$1"

case "$task" in
provision | destroy | enter)
    $task
    ;;
*)
    echo "./cli.sh [provision|destroy|enter]"
    ;;
esac

