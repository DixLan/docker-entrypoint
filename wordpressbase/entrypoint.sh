#!/bin/bash

# Démarrage de MariaDB
service mysql start

# Initialisation de la base WordPress
if [ ! -f /var/lib/mysql/initialized.flag ]; then
    echo "[INFO] Création de la base de données WordPress..."
    mysql -e "CREATE DATABASE wordpress;"
    mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
    mysql < /articles.sql
    touch /var/lib/mysql/initialized.flag
fi

# Création de wp-config.php s'il n'existe pas
if [ ! -f /srv/www/wordpress/wp-config.php ]; then
    echo "[INFO] Génération du fichier wp-config.php..."
    cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
    sed -i "s/database_name_here/wordpress/" /srv/www/wordpress/wp-config.php
    sed -i "s/username_here/wpuser/" /srv/www/wordpress/wp-config.php
    sed -i "s/password_here/wppassword/" /srv/www/wordpress/wp-config.php
    chown www-data:www-data /srv/www/wordpress/wp-config.php
fi

# Démarrage d'Apache
echo "[INFO] Démarrage d'Apache..."
exec apache2ctl -D FOREGROUND
