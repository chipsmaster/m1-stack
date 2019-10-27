#!/bin/sh

set -e

echo "init !"

if [ -f .env ]
then
	rm -i .env
fi

sed "s/#UID#/$(id -u)/" .env.sample | sed "s/#GID#/$(id -g)/" > .env

cp -vi docker-compose.override.sample.yml docker-compose.override.yml

