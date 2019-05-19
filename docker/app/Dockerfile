FROM debian:9 as builder
WORKDIR /source
ARG GIT_BRANCH="master"
ARG GIT_HTTP="https://gitlab.terhaak.de/jojo/anime-metadata-cache.git"

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# download source code
RUN git clone --depth 1 --branch "$GIT_BRANCH" "$GIT_HTTP" /source

FROM debian:9
EXPOSE 8080

RUN apt-get update && apt-get install -y --no-install-recommends \
        apache2 \
        ca-certificates \
        libapache2-mod-php7.0 \
        php7.0-cli \
        php7.0-curl \
        php7.0-json \
        php7.0-mysql \ 
        php7.0-xml \
        php-redis \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /var/www/html/*

RUN mkdir -p /var/log/apache2/ /var/run/apache2/ /var/lock/apache2/ \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stdout /var/log/apache2/error.log \
    && chown www-data:www-data /var/log/apache2/ /var/run/apache2/ /var/lock/apache2/ \
    && a2disconf other-vhosts-access-log.conf \
    && a2enmod rewrite 

COPY ./rootfs/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./rootfs/ports.conf /etc/apache2/ports.conf

COPY ./rootfs/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY --from=builder /source/src /var/www/html
COPY ./rootfs/config.php /var/www/html/config.php

ENV "APP_BASE_URL" ""
ENV "REDIS_HOST" ""
ENV "REDIS_PORT" "6379"
ENV "MYSQL_HOST" ""
ENV "MYSQL_PORT" "3306"
ENV "MYSQL_DBNAME" ""
ENV "MYSQL_USER" ""
ENV "MYSQL_PASSWORD" ""

WORKDIR /var/www/html
USER 33
CMD /entrypoint.sh