# Start with PHP FPM image
FROM php:8.3-fpm-alpine

ARG HOST_UID=1000
ARG HOST_GID=1000

# Install docker-php-extension-installer
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions

# Install dependencies and PHP extensions
RUN apk add --no-cache \
    nginx \
    shadow \
    npm \
    msmtp \
    imagemagick \
    $PHPIZE_DEPS 

RUN install-php-extensions \
    opcache pdo_mysql pdo_pgsql gd intl zip bcmath bz2 calendar curl exif \
    fileinfo ftp gettext imap ldap mbstring mysqli soap sodium sysvsem sysvshm xsl \
    pdo_sqlite pgsql pcntl sockets redis imagick uploadprogress memcached mongodb xdebug xhprof

# Configure PHP
RUN echo -e "\n opcache.enable=1 \n opcache.enable_cli=1 \n opcache.memory_consumption=128 \n opcache.interned_strings_buffer=8 \n opcache.max_accelerated_files=4000 \n opcache.revalidate_freq=60 \n opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini && \
    echo -e "\n xdebug.mode=debug \n xdebug.remote_host=localhost \n xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo -e "\n xhprof.output_dir='/var/tmp/xhprof'" >> /usr/local/etc/php/conf.d/docker-php-ext-xhprof.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Install Node.js
RUN apk add --no-cache nodejs npm

# Clean up
RUN apk del $PHPIZE_DEPS && \
    rm -rf /var/cache/apk/* /tmp/*

# Update PHP-FPM config to use the new UID/GID
RUN sed -i "s|user = www-data|user = www-data|g" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s|group = www-data|group = www-data|g" /usr/local/etc/php-fpm.d/www.conf

# Create directory for web files and set permissions
RUN mkdir -p /var/www/public && \
    chown -R www-data:www-data /var/www/public

# Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Set working directory
WORKDIR /var/www/public

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Adjust user and group IDs
RUN groupmod -g $HOST_GID www-data && \
    usermod -u $HOST_UID www-data

# Start PHP-FPM and Nginx
CMD ["/start.sh"]