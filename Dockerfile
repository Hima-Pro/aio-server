FROM alpine:3.18

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Ibrahim Megahed <tdim.dev@gmail.com>" \
    architecture="amd64/x86_64" \
    alpine-version="3.18.3" \
    apache2-version="2.4.57" \
    php-version="8.1.23" \
    phpmyadmin-version="5.2.1" \
    mariadb-version="10.11.5" \
    build="6-Nov-2023" \
    org.opencontainers.image.title="aio-server" \
    org.opencontainers.image.description="All In One server. Apache2+PHP, PHPMyAdmin and MariaDB server on one Alpine Linux docker image." \
    org.opencontainers.image.authors="Ibrahim Megahed <tdim.dev@gmail.com>" \
    org.opencontainers.image.vendor="Hima-Pro" \
    org.opencontainers.image.version="v1.0.0" \
    org.opencontainers.image.url="https://hub.docker.com/r/tdim/aio-server/" \
    org.opencontainers.image.source="https://github.com/Hima-Pro/aio-server" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

COPY ./src /var/www/src
COPY ./htdocs /var/www/htdocs
WORKDIR /var/www

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    apache2 mariadb php phpmyadmin \
    # mariadb-client mariadb-server-utils \
    php-apache2 php-curl php-gd php-zip php-mbstring php-mysqli php-pdo_mysql php-sodium \
    php-ctype php-session php-xml php-json php-iconv php-sqlite3 php-pdo_sqlite \
    supervisor composer pwgen bash && \
    rm -f /var/cache/apk/*

RUN cp ./src/configs/php.ini /etc/php81/conf.d/custom.ini && \
    sed -i 's#/var/www/localhost/htdocs#/var/www/htdocs#g' /etc/apache2/httpd.conf && \
    sed -i 's#/var/www/localhost/cgi-bin#/var/www/cgi-bin#g' /etc/apache2/httpd.conf && \
    sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf && \
    sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/httpd.conf && \
    bash -c "mkdir -p /var/www/{aio-logs,src/setup/{initdb,pre-{init,exec}}.d}" && \
    chown -R apache:apache ./htdocs && \
    cp -r localhost/cgi-bin . && \
    rm -rf localhost && \
    chmod 755 ./src/setup/*.sh

EXPOSE 80 8080 3306

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/var/www/src/configs/supervisord.conf"]