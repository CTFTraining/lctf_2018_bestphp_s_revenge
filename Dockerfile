FROM php:7.0-fpm-alpine

LABEL Author="Virink <virink@outlook.com>"

COPY files /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
    && apk update \
    && apk add nginx libxml2-dev \
    # php ext
    && docker-php-source extract \
    && docker-php-ext-install soap \
    && docker-php-source delete \
    && mkdir /run/nginx \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i -e 's/display_errors.*/display_errors = Off/' /usr/local/etc/php/php.ini \
    # configure file
    && mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    && mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    && mv /tmp/vhost.nginx.conf /etc/nginx/conf.d/default.conf \
    # www
    && mv /tmp/src/* /var/www/html \
    && chmod -R -w /var/www/html \
    # && stat /var/www/html/upload || mkdir /var/www/html/upload \
    # && chmod -R 777 /var/www/html/upload \
    && chown -R www-data:www-data /var/www/html \
    # clear
    && rm -rf /tmp/* \
    && rm -rf /etc/apk

EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD ["/bin/sh", "-c", "docker-php-entrypoint"]