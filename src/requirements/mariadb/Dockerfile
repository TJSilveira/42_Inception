FROM alpine:3.23.0

EXPOSE 3306

# ARG FILENAME="mariadb-12.2.1"
# ARG EXTENSION="tar.gz"

# ADD https://archive.mariadb.org/${FILENAME}/source/${FILENAME}.${EXTENSION}

RUN	apk add mariadb mariadb-client --no-cache

WORKDIR	/var/lib/mysql

COPY	./tools/entrypoint.sh /entrypoint.sh
COPY	./conf/docker.cnf /docker.cnf
RUN		chmod +x /entrypoint.sh

# ADD ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["/entrypoint.sh"]
