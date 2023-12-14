#!/bin/sh

sleep 15
if test ! -f /var/www/wordpress/wp-config.php; then
    mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
fi
wp config set --allow-root --add --path='/var/www/wordpress' DB_NAME $SQL_DATABASE
wp config set --allow-root --add --path='/var/www/wordpress' DB_USER $SQL_USER
wp config set --allow-root --add --path='/var/www/wordpress' DB_PASSWORD $SQL_PASSWORD
wp config set --allow-root --add --path='/var/www/wordpress' DB_HOST mariadb:3306
wp core install --allow-root --path='/var/www/wordpress' --url=example.com --title=Example --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWD} --admin_email=${WP_ADMIN_EMAIL}
wp user create --allow-root --path='/var/www/wordpress' ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWD}
mkdir -p /run/php
/usr/sbin/php-fpm7.3 -F