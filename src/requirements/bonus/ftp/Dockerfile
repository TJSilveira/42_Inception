FROM alpine:3.23.0

RUN apk update && apk upgrade && apk add --no-cache vsftpd

COPY ./tools/entrypoint.sh /entrypoint.sh
COPY ./conf/vsftpd.conf /vsftpd.conf

CMD ["/entrypoint.sh"]