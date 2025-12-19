#!/bin/sh

if [! -f "/etc/redis/.configured"]; then
	touch /etc/redis/.configured

	sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis.conf
	sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g" /etc/redis.conf
	sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis.conf
fi

redis-server --protected-mode no
