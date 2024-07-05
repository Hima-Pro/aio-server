#!/bin/sh

case "$1" in
    mariadb)
          mkdir -p /run/mysqld
          chown -R mysql:mysql /run/mysqld
          mkdir -p /var/lib/mysql
          chown -R mysql:mysql /var/lib/mysql
          mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
          MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-$(pwgen 16 1)}"
          echo $MYSQL_ROOT_PASSWORD > /app/mysql-root-pw.txt
          tfile=`mktemp`
          
          printf "
            USE mysql;
            FLUSH PRIVILEGES ;
            GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
            GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
            SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
            DROP DATABASE IF EXISTS test ;
            FLUSH PRIVILEGES ;
            " > $tfile
          /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
          rm -f $tfile
        ;;
    web)
        printf "
          max_file_uploads = 1024
          upload_max_filesize = 1024M
          post_max_size = 1024M
          " > /etc/php83/conf.d/custom.ini
        sed -i "/LoadModule rewrite_module/s/^#//g" /etc/apache2/httpd.conf
        sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/httpd.conf
        ;;
    *)
        echo "Usage: $0 {mariadb|web}"
        exit 1
        ;;
esac