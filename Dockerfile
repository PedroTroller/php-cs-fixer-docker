FROM composer:1.8.6 AS composer

FROM php:8.0.9-cli

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    git \
 && rm -rf /var/lib/apt/lists/*

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /php-cs-fixer

COPY . /php-cs-fixer

RUN composer global require --prefer-source --no-progress hirak/prestissimo \
 && composer install --optimize-autoloader --prefer-source --no-progress \
 && composer global remove --no-progress hirak/prestissimo hirak/prestissimo

ENTRYPOINT ["vendor/bin/php-cs-fixer"]
