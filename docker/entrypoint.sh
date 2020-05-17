#!/usr/bin/env bash
set -e

if [[ -z "${UID}" ]]; then
    echo "UID variable value is required"
    exit 1
fi

if [[ -z "${GID}" ]]; then
    echo "GID variable value is required"
    exit 1
fi

group=$(grep ${GID} /etc/group | awk -F: '{print $1}')

if [[ ! -z "${group}" ]]; then
    GID=$((GID+1))
fi

groupmod -g ${GID} hostuser
usermod -u ${UID} hostuser  > /dev/null 2>&1

exec runuser -u hostuser "$@"
