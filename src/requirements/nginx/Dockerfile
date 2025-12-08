FROM alpine:latest

EXPOSE 443

ARG FILENAME="nginx-1.28.0"
ARG EXTENSION="tar.gz"

ADD https://nginx.org/download/${FILENAME}.${EXTENSION} .

RUN apk add --no-cache pcre zlib openssl && \
    apk add --no-cache \
            --virtual .build-deps \
            build-base \ 
            pcre-dev \
            zlib-dev \
            openssl-dev && \
    tar -xvf ${FILENAME}.${EXTENSION} && rm ${FILENAME}.${EXTENSION} && \
    cd ${FILENAME} && \
    ./configure \
        --sbin-path=/usr/bin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --with-pcre \
        --pid-path=/var/run/nginx.pid \
        --with-http_ssl_module && \
    make && make install && \
    cd / && rm -rfv /${FILENAME} && \
    apk del .build-deps

RUN mkdir -p /etc/nginx/ssl && \
	cd /etc/nginx/ssl && \
	openssl genrsa -out server.key 2048 && \
	openssl req -new -x509 -key server.key -out server.crt -days 365 -subj "/CN=tsilveir.42.fr"

ADD ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
