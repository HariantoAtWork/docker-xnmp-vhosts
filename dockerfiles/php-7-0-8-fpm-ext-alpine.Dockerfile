FROM php:7.0.8-fpm-alpine

RUN apk add --no-cache --update \
        libmcrypt \
        libmcrypt-dev \
    && docker-php-ext-install \
        mysqli \
        opcache \
        intl \
        sockets \
        mcrypt \
    && rm -rf /tmp/* /var/cache/apk/* \
    && echo "=============================================" \
    && php -m
