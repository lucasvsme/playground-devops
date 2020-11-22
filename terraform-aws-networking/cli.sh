#!/bin/sh

region=""
access_key=""
secret_key=""

provision () {
    terraform validate
    terraform apply -auto-approve \
        -var region="${region:=$AWS_REGION}" \
        -var access_key="${access_key:=$AWS_ACCESS_KEY}" \
        -var secret_key="${secret_key:=$AWS_SECRET_KEY}"
}

destroy () {
    terraform destroy -auto-approve \
        -var region="${region:=$AWS_REGION}" \
        -var access_key="${access_key:=$AWS_ACCESS_KEY}" \
        -var secret_key="${secret_key:=$AWS_SECRET_KEY}"
}

task=$1

case "$task" in
    provision | destroy)
        $task
        ;;
    *)
        echo "./cli.sh [provision|destroy]"
        ;;
esac
