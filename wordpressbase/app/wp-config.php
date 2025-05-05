cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sed -i "s/database_name_here/wordpress/" /srv/www/wordpress/wp-config.php
sed -i "s/username_here/wpuser/" /srv/www/wordpress/wp-config.php
sed -i "s/password_here/wppassword/" /srv/www/wordpress/wp-config.php
