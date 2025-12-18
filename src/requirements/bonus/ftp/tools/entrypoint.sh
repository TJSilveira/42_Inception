#!/bin/sh

if [ ! -f "/etc/vsftpd/.configured" ]; then
	touch /etc/vsftpd/.configured

	adduser "$FTP_USER" --disabled-password
	echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
	chown -R "$FTP_USER:$FTP_USER" /var/www/html
	echo "$FTP_USER" | tee -a /etc/vsftpd.userlist &> /dev/null
fi

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
