#!/bin/sh

filename="kubernetes.yaml"
label="app.kubernetes.io/name=playground"

provision () {
    kubectl apply --all --filename="$filename"
}

destroy () {
    kubectl delete --all --filename="$filename"
}

logs () {
    kubectl logs --selector="$label"
}

task=$1

case $task in
    provision | destroy | logs)
        $task
        ;;
    *)
        echo "./cli.sh [provision|destroy|logs]"
        ;;
esac
