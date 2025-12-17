#!/bin/sh

# Sets behavior that exits the script if there is some error in the course of the script
set -e

cd /var/www/html

# 	Sets wp-config.php file if not yet available. This permits mounting volumes that were 
#	set up before without overriding them.
if [ ! -f wp-config.php ]; then
    wp core download	--allow-root

	until mysql -h "$WP_DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -e "SELECT 1" >/dev/null 2>&1; do
		sleep 2
	done

    wp config create	--dbname="$DB_NAME" \
						--dbuser="$DB_USER" \
						--dbpass="$DB_PASSWORD" \
						--dbhost="$WP_DB_HOST" --allow-root
    wp core install		--url="$DOMAIN_NAME" \
						--title="$WP_TITLE" \
						--admin_user="$WP_ADMIN_USER" \
						--admin_password="$WP_ADMIN_PASSWORD" \
						--admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
	wp user create		$WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --allow-root


	# <Bonus> REDIS
	wp configure set WP_REDIS_HOST redis --allow-root
	wp configure set WP_REDIS_PORT 6379 --allow-root
	wp configure set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	wp redis enable --allow-root
	# </Bonus>
else
	echo "Wordpress is already downloaded. Please ensure that the definitions were created correctly."
fi

# Listen to the TCP port 9000
sed -i 's|listen = .*|listen = 9000|g' /etc/php85/php-fpm.d/www.conf

#	Removes the script as it is no longer needed.
rm -rf /entrypoint.sh

#	Creates PID 1 using foreground mode.
exec php-fpm85 -F
