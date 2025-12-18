FROM alpine:3.23.0

RUN	apk add --no-cache vsftpd

COPY ./tools/entrypoint.sh /entrypoint.sh
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN	chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]