docker build -t ghcr.io/evnix/frankenphp:1.2.0-php8.3.8-alpine zscripts/docker-files/frankenphp83
docker push ghcr.io/evnix/frankenphp:1.2.0-php8.3.8-alpine


docker tag 9f3e8109f072 ghcr.io/evnix/frankenphp:1.2.0-php8.3.8-alpine-laravel
docker push ghcr.io/evnix/frankenphp:1.2.0-php8.3.8-alpine-laravel
docker tag 9f3e8109f072 ghcr.io/evnix/frankenphp:1.2.0-php8.3.8-alpine-wordpress
docker push ghcr.io/evnix/frankenphp:1.2.0-php8.3.8-alpine-wordpress
