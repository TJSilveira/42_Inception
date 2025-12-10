#!/bin/bash

# Sets behavior that exits the script if there is some error in the course of the script
set -e

cd /var/lib/mysql

# 	Sets mysql file if not yet available. This permits mounting volumes that were 
#	set up before without overriding them.
if [ ! -d mysql ]; then
	mkdir -p /etc/my.cnf.d
    mv /docker.cnf /etc/my.cnf.d/docker.cnf
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

until mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking; do
	echo "Waiting for Maria DB initialization"
	sleep 2
done

mariadb -u root < /db_conf.sql

#	Removes the script as it is no longer needed.
rm -rf /entrypoint.sh

#	Creates PID 1 using daemon mode.
exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
