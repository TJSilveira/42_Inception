# FROM alpine:3.23.0

# RUN apk --update add redis 

# EXPOSE 6379

# COPY	tools/entrypoint.sh /entrypoint.sh
# RUN		chmod +x /entrypoint.sh

# CMD ["/entrypoint.sh"]
FROM alpine:3.23.0

RUN apk --update add redis 

EXPOSE 6379

RUN		sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis.conf && \
		sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g" /etc/redis.conf && \
		sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis.conf

CMD ["redis-server", "--protected-mode", "no"]