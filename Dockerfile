FROM ubuntu:16.04

MAINTAINER Joseph Ian Farillas <jfarillas@gmail.com>

RUN export LC_ALL=C

RUN apt-get update \
    && apt-get install -y curl zip unzip git software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update

RUN apt-get install -y --allow-unauthenticated php7.0-fpm php7.0-cli php7.0-mcrypt php7.0-gd php7.0-mysql \
       php7.0-pgsql php7.0-imap php-memcached php7.0-mbstring php7.0-xml php7.0-curl \
       php7.0-intl php7.0-pdo-dblib php7.0-redis php-apcu php7.0-readline \
       php7.0-xml php7.0-zip php7.0-sqlite3

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php

RUN apt-get remove -y --purge software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD www.conf /etc/php/7.0/fpm/pool.d/www.conf

EXPOSE 9000
CMD ["php-fpm7.0", "--allow-to-run-as-root"]
