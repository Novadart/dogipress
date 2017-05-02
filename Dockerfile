FROM wordpress:4.7.3

# Add here any custom extension. See https://store.docker.com/images/php?tab=description
RUN docker-php-ext-install zip

# in config/php.ini go custom PHP configurations.  See https://store.docker.com/images/php?tab=description
COPY config/php.ini /usr/local/etc/php/

COPY ./wordpress /var/www/html

# Uncomment this if you are running the image standalone and wish the content of wp-content/uploads to be persisted
#VOLUME /var/www/html/wp-content/uploads

# Fix the permissions of the wordpress files - see http://stackoverflow.com/questions/18352682/correct-file-permissions-for-wordpress
WORKDIR /var/www/html
RUN if [ -z "$(ls -A ./)" ]; then chown www-data:www-data -R *; fi
RUN find . -type d -exec chmod 755 {} \;
RUN find . -type f -exec chmod 644 {} \;