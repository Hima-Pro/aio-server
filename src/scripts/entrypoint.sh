#!/bin/sh

if [ -d /app/pkgs ]; then
    apk add --allow-untrusted --no-network /app/pkgs/*.apk
    rm -rf /app/pkgs
fi

configure() {
    if [ -f /app/scripts/configure.sh ]; then
        sh /app/scripts/configure.sh $@
        rm /app/scripts/configure.sh
    fi
}

case "$1" in
    all)
        configure web
        configure mariadb
        /usr/bin/supervisord -c /app/configs/supervisord.conf
        ;;
    mariadb)
        configure mariadb
        /usr/bin/supervisord -c /app/configs/supervisord-mariadb.conf
        ;;
    web)
        configure web
        /usr/bin/supervisord -c /app/configs/supervisord-web.conf
        ;;
    *)
        echo "Usage: $0 {all|mariadb|web}"
        exit 1
        ;;
esac