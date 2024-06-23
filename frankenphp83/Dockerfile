FROM dunglas/frankenphp:1.2.0-php8.3.8-alpine

ENV SERVER_NAME=:80

# Install build dependencies and PHP extensions in a single layer
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS msmtp && \
    install-php-extensions \
    opcache pdo_mysql pdo_pgsql gd intl zip bcmath bz2 calendar curl exif \
    fileinfo ftp gettext imagick imap ldap mbstring mcrypt memcached mongodb \
    mysqli openssl redis soap sodium sysvsem sysvshm xmlrpc xsl \
    pdo_sqlite sqlite3 pgsql xml dom simplexml tokenizer ctype json \
    pcntl posix sockets zlib && \
    pecl install uploadprogress && \
    docker-php-ext-enable uploadprogress && \
    # Configure PHP
    echo -e "\n opcache.enable=1 \n opcache.enable_cli=1 \n opcache.memory_consumption=128 \n opcache.interned_strings_buffer=8 \n opcache.max_accelerated_files=4000 \n opcache.revalidate_freq=60 \n opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini && \
    echo -e "\n xdebug.mode=debug \n xdebug.remote_host=localhost \n xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo -e "\n xhprof.output_dir='/var/tmp/xhprof'" >> /usr/local/etc/php/conf.d/docker-php-ext-xhprof.ini && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    # Install WP-CLI
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    # Clean up
    apk del .build-deps $PHPIZE_DEPS && \
    rm -rf /var/cache/apk/* /tmp/*

# Set permissions for install-php-extensions
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync
