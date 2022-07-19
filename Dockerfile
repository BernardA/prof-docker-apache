FROM php:8.1-apache AS symfony_php

RUN a2enmod rewrite

RUN apt-get update \
  && apt-get install -y libpq-dev libzip-dev git libxml2-dev nano wget --no-install-recommends \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql pgsql zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://getcomposer.org/download/2.3.5/composer.phar \
    && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer


COPY docker/php/apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY docker/php/php.ini /usr/local/etc/php/conf.d/app.ini

# COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
# RUN chmod +x /usr/local/bin/docker-entrypoint

COPY . /var/www

WORKDIR /var/www
# RUN composer install
RUN composer install --prefer-dist --no-progress --no-interaction

# RUN php bin/console doctrine:migrations:migrate --no-interaction
# ENTRYPOINT ["docker-entrypoint"]


RUN mkdir ./var/cache/pfv && mkdir ./var/log/pfv && chmod -R 777 ./var/cache && chmod -R 777 ./var/log


