FROM alpine:3.23.0

EXPOSE 9000

RUN apk update && \
	apk add --no-cache \
	php85 \
	php85-fpm \
	php85-phar \
	php85-cli \
	php85-curl \
	php85-openssl \
	php85-mysqlnd \
	php85-mysqli \
	php85-iconv \
    php85-mbstring \
	mysql-client \
	curl && \
	ln -s /usr/bin/php85 /usr/bin/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	echo "memory_limit = 512M" > /etc/php85/conf.d/memory-limit.ini

WORKDIR	/var/www/html

COPY	tools/entrypoint.sh /entrypoint.sh
RUN		chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
