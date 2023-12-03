#!/bin/sh

provision() {
  docker compose up --detach --force-recreate --renew-anon-volumes
}

destroy() {
  docker compose down
}

stats() {
  container_name="resource-limit"
  docker stats --no-stream "$container_name"
}

case "$1" in
provision | destroy | stats)
  $1
  ;;
*)
  echo "./cli.sh [provision|destroy|stats]"
  ;;
esac
