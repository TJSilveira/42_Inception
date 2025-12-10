#!/bin/bash

# Sets behavior that exits the script if there is some error in the course of the script
set -e

cd /var/www/html

# 	Sets wp-config.php file if not yet available. This permits mounting volumes that were 
#	set up before without overriding them.
if [ ! -f wp-config.php ]; then
    wp core download	--allow-root
    wp config create	--dbname="$MARIADB_NAME" \
						--dbuser="$MARIADB_USER" \
						--dbpass="$MARIADB_PASSWORD" \
						--dbhost="$WP_DB_HOST" --allow-root
    wp core install		--url="$DOMAIN_NAME" \
						--title="$WP_TITLE" \
						--admin_user="$WP_ADMIN_USER" \
						--admin_password="$WP_ADMIN_PASSWORD" \
						--admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
	wp user create		$WP_USER $WP_USER_EMAIL --user_pass=WP_USER_PASSWORD --allow-root
fi

#	Removes the script as it is no longer needed.
rm -rf /entrypoint.sh

#	Creates PID 1 using daemon mode.
exec php-fpm85 -D
