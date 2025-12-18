FROM alpine:3.23.0

EXPOSE 9000

RUN apk update && \
  	apk add --no-cache \
	curl \
	less \
	mariadb-client \
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
	php85-ctype \
	php85-session \
	mysql-client && \
	curl -L -O https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php && \
    mkdir -p /var/www/html && \
	mv ./adminer-5.4.1.php /var/www/html/index.php && \
    adduser -u 82 -D -S -G www-data www-data && \
    chown www-data:www-data /var/www/html/index.php && \
    chmod 644 /var/www/html/index.php


COPY /conf/www.conf /etc/php85/php-fpm.d/www.conf

CMD ["php-fpm85", "--nodaemonize"]