#!/bin/sh

# Sets behavior that exits the script if there is some error in the course of the script
set -e

cd /var/lib/mysql

# Create dir to hold the configuration file. If it has no config inside, add it. 
mkdir -p /etc/my.cnf.d
if [ -f /docker.cnf ]; then
    mv /docker.cnf /etc/my.cnf.d/docker.cnf
fi

# 	Sets mysql file if not yet available. This permits mounting volumes that were 
#	set up before without overriding them.
if [ ! -d mysql ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql

	mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
	MARIADB_PID=$!

	until mariadb -u root -e "SELECT 1" &>/dev/null; do
		sleep 2
	done

	# Run configuration SQL
	mariadb -u root < /db_conf.sql

	# Kill temp server
	kill $MARIADB_PID
	wait $MARIADB_PID
fi

#	Removes the script and db_config as they are no longer needed.
rm -rf /entrypoint.sh
rm -rf /db_conf.sql

#	Creates PID 1 using daemon mode.
exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
