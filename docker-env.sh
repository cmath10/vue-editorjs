#!/usr/bin/env bash

uid=$(id -u)
gid=$(id -g)
ip=$(ip addr show docker0 | grep inet | awk '{print $2}' | head -n 1 | awk -F "/" '{print $1}')

touch .env

p="uid=${uid}\ngid=${gid}\nip=${ip}"
echo -e "${p}"

echo -e "${p}" | cat - .env > temp && mv temp .env
