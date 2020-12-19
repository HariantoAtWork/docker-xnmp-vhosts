FROM php:8.0.0-fpm-alpine

RUN curl -s https://getcomposer.org/installer | php \
  # move composer into a bin directory you control:
  && mv composer.phar /usr/local/bin/composer \
  # double check composer works
  && composer about

RUN php -m \
  && echo "=============================================" \
  && echo "PHP MODULES available not yet installed: bcmath \
  bz2 \
  calendar \
  dba \
  enchant \
  exif \
  ffi \
  gd \
  gettext \
  gmp \
  imap \
  intl \
  ldap \
  mysqli \
  oci8 \
  odbc \
  opcache \
  pcntl \
  pdo_dblib \
  pdo_firebird \
  pdo_mysql \
  pdo_oci \
  pdo_odbc \
  pdo_pgsql \
  pgsql \
  pspell \
  shmop \
  snmp \
  soap \
  sockets \
  sysvmsg \
  sysvsem \
  sysvshm \
  tidy \
  xsl \
  zend_test \
  zip"

RUN docker-php-ext-install \
  pdo_mysql

RUN rm -rf /tmp/* /var/cache/apk/* \
  && echo "=============================================" \
  && php -m

