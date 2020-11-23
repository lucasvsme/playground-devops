#!/bin/sh

filename="kubernetes.yaml"
label="app.kubernetes.io/name=playground"
image="com.example/server:latest"

bake () {
    docker build --tag="$image" --file=server/Dockerfile server/
}

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
    bake | provision | destroy | logs)
        $task
        ;;
    *)
        echo "./cli.sh [bake|provision|destroy|logs]"
        ;;
esac
