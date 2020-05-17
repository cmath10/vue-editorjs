#!/usr/bin/env bash

RUNNING_CONTAINER_ID="$(docker ps -qf "ancestor=vue-editorjs-node")"

if [[ -z "${RUNNING_CONTAINER_ID}" ]]
then
    export uid=$(id -u)
    export gid=$(id -g)
    export port_karma=3076
    export port_webpack=3080

    docker-compose run --rm --service-ports node bash
else
    echo "Connecting to container ${RUNNING_CONTAINER_ID}..."
    docker exec -it --user hostuser ${RUNNING_CONTAINER_ID} bash
fi
