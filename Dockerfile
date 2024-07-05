FROM alpine:3.20

# Image info
LABEL maintainer="Ibrahim Megahed <tdim.dev@gmail.com>" \
    org.opencontainers.image.title="aio-server all" \
    org.opencontainers.image.description="All In One server. apache2, php, phpmyadmin and mariadb in one Alpine Linux docker image." \
    org.opencontainers.image.authors="Ibrahim Megahed <tdim.dev@gmail.com>" \
    org.opencontainers.image.version="2.0.0" \
    architecture="amd64/x86_64" \
    build="6-Jul-2024"

# First setup
COPY . /app/source
WORKDIR /app

# Download packages, Install Later - just to keep image size small
RUN mkdir pkgs && \
    apk add --no-cache aom-libs && \
    apk fetch --no-cache -R -o ./pkgs \
    # Main pkgs
    apache2 mariadb php83 phpmyadmin composer pwgen supervisor \
    # PHP extensions
    php-apache2 php-curl php-gd php-zip php-mbstring php-mysqli php-pdo_mysql php-sodium \
    php-ctype php-session php-xml php-json php-iconv php-sqlite3 php-pdo_sqlite

# Final setup - restructure app directory
RUN mkdir /app/logs /app/pids && \
    cp -r /app/source/src/configs /app/source/src/scripts /app && \
    chmod -R 777 /app/scripts

EXPOSE 80 8080 3306

ENTRYPOINT ["/app/scripts/entrypoint.sh", "all"]