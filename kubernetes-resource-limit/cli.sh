#!/bin/sh

filename="kubernetes.yaml"
label="app.kubernetes.io/name=resource-limit"

provision() {
  kubectl apply --all --filename="$filename"
}

destroy() {
  kubectl delete --all --filename="$filename"
}

describe() {
  kubectl get pods \
    --selector "$label" \
    --output jsonpath='{.items[].spec.containers[].resources}' | jq
}

task=$1

case $task in
provision | destroy | describe)
  $task
  ;;
*)
  echo "./cli.sh [provision|destroy|describe]"
  ;;
esac
