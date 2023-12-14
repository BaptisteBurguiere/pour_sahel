#!/bin/sh

cp /usr/share/mysql/mysql.server /usr/local/bin
chmod +x /usr/local/bin/mysql.server
chown -R mysql:mysql /var/lib/mysql

echo ""
echo "Changing root password"
echo ""

mysqld_safe --skip-grant-tables &
sleep 5

mysql -u root <<EOF
UPDATE mysql.user SET authentication_string = PASSWORD('${SQL_ROOT_PASSWORD}') WHERE User = 'root';
FLUSH PRIVILEGES;
EOF

mysqladmin shutdown -uroot --password="${SQL_ROOT_PASSWORD}"

echo
echo "creating database and user"
echo

mysqld_safe &
sleep 5

mysql -uroot -p"${SQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
FLUSH PRIVILEGES;
EOF

mysqladmin shutdown -uroot --password="${SQL_ROOT_PASSWORD}"

echo ""
echo "restarting in background\n"
exec mysqld_safe