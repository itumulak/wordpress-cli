FROM itumulak/apache2-php:latest
MAINTAINER Ian Tumulak <edden87@gmail.com>

# Download WordPress
RUN curl -L "https://wordpress.org/latest.tar.gz" > /wordpress-latest.tar.gz && \
    rm /var/www/html/index.html && \
    tar -xzf /wordpress-latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm /wordpress-latest.tar.gz

# Download WordPress CLI
RUN curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/bin/wp  && \
    chmod +x /usr/bin/wp

# WordPress configuration
ADD wp-config.php /var/www/html/wp-config.php

# Apache access
RUN chown -R www-data:www-data /var/www/html

# Add configuration script
ADD config_wp.sh /config_wp.sh
RUN chmod 755 /*.sh

# MySQL environment variables
ENV WP_DB_HOST localhost
ENV WP_DB_USER wordpress
ENV WP_DB_PASSWORD wordpress
ENV WP_DB_NAME wordpress

# WordPress environment variables
ENV WP_URL localhost
ENV WP_TITLE WordPress Demo
ENV WP_ADMIN_USER admin
ENV WP_ADMIN_PASSWORD admin
ENV WP_ADMIN_EMAIL user@mail.com

EXPOSE 80 3306

CMD ["/config_wp.sh"]