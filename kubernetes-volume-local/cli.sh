#!/bin/sh

filename="kubernetes.yaml"

provision () {
    kubectl apply --all --filename="$filename"
}

destroy () {
    kubectl delete --all --filename="$filename"
}

task=$1

case $task in
    provision | destroy)
        $task
        ;;
    *)
        echo "./cli.sh [provision|destroy]"
        ;;
esac
