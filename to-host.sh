#!/usr/bin/env bash
set -x
set -eo pipefail

SERVER_USER=${SERVER_USER:=shane}
SERVER_IP=${SERVER_IP:=192.168.5.102}

docker build --target runtime --tag homepage .
docker save homepage | gzip > /tmp/homepage_saved.tar.gz
scp /tmp/homepage_saved.tar.gz ${SERVER_USER}@${SERVER_IP}:/tmp
scp docker-compose.yml ${SERVER_USER}@${SERVER_IP}:/tmp
ssh ${SERVER_USER}@${SERVER_IP} 'docker load < /tmp/homepage_saved.tar.gz'