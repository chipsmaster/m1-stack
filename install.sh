#!/bin/sh

set -e

echo "Command line installation..."

base_url="http://magento1.local/"
backend_url="${base_url}admin/"
admin_username="admin"
admin_password="azeazeaze123123"

docker-compose exec -u magento apache php /var/www/magento/install.php \
	--license_agreement_accepted yes \
	--locale en_US --timezone "America/Los_Angeles" --default_currency USD \
	--db_host mysql --db_name magento --db_user magento --db_pass magento \
	--url "$base_url" --use_rewrites yes \
	--use_secure no --secure_base_url "$base_url" --use_secure_admin no \
	--admin_lastname Owner --admin_firstname Store --admin_email "admin@example.com" \
	--admin_username "$admin_username" --admin_password "$admin_password"

echo "Frontend: $base_url"
echo "Backend: $backend_url"
echo "Admin user: $admin_username / $admin_password"

./lockfs.sh

