#!/bin/bash

echo "=> Setting up wp-config.php"
sed -i "s/WP_DB_HOST/$WP_DB_HOST/g" /var/www/html/wp-config.php
sed -i "s/WP_DB_USER/$WP_DB_USER/g" /var/www/html/wp-config.php
sed -i "s/WP_DB_PASSWORD/$WP_DB_PASSWORD/g" /var/www/html/wp-config.php
sed -i "s/WP_DB_NAME/$WP_DB_NAME/g" /var/www/html/wp-config.php

echo "=> Starting up apache2..."
service apache2 start

echo "=> Initiating zsh..."
zsh