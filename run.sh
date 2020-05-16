#!/bin/sh
exec docker run \
	--rm \
	--interactive \
	--tty \
	--volume mcdata:/data:rw \
	--publish 25565:25565 \
	--dns 1.1.1.1 \
	--env MEMORY_SIZE=2048 \
	--env EULA=true \
	--name minecraft \
	flatulation/minecraft:latest
