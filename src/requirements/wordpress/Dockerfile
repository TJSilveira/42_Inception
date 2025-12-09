FROM alpine:3.23.0

EXPOSE 9000

RUN apk update && \
	apk add --no-cache php85 php85-fpm

# RUN rc-service php-fpm85 start
# RUN rc-update add php-fpm85 default

# ADD ./conf/wordpress.conf /etc/nginx/nginx.conf

CMD ["php-fpm85"]
