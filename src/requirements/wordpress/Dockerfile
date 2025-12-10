FROM alpine:3.23.0

EXPOSE 9000

RUN apk update && \
	apk add --no-cache php85 php85-fpm curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR	/var/www/http

COPY	tools/entrypoint.sh /entrypoint.sh
RUN		chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
