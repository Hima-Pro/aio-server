#!/bin/sh

if [ -d /app/pkgs ]; then
    apk add --allow-untrusted --no-network /app/pkgs/*.apk
    rm -rf /app/pkgs
fi

looper() {
    sleep 1000
    looper
}

configure() {
    if [ -f /app/scripts/configure.sh ]; then
        sh /app/scripts/configure.sh $@
    fi
}

case "$1" in
    all)
        configure web
        configure mariadb
        rm -f /app/scripts/configure.sh
        rc-service apache2.sh restart
        rc-service mariadb.sh restart
        rc-service phpmyadmin.sh restart
        looper
        ;;
    mariadb)
        configure mariadb
        rm -f /app/scripts/configure.sh
        rc-service mariadb.sh restart
        looper
        ;;
    web)
        configure web
        rm -f /app/scripts/configure.sh
        rc-service apache2.sh restart
        looper
        ;;
    *)
        echo "Usage: $0 {all|mariadb|web}"
        exit 1
        ;;
esac