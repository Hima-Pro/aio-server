# All In One server
All In One server. Apache2+PHP, PHPMyAdmin and MariaDB server on one Alpine Linux docker image.

## Overview
[Read the full README.md for more informations](https://github.com/Hima-Pro/aio-server/blob/main/README.md)

## Run with docker compose

### Run all servers
```yml
version: "3.9"
services:
  aio:
    image: tdim/aio-server:latest
    container_name: aio
    volumes:
      - ./project:/var/www/htdocs
      - ./db:/run/mysqld
    ports:
      - 80:80
      - 8080:8080
      - 3306:3306
    environment:
      - MYSQL_ROOT_PASSWORD=aio
      - MYSQL_DATABASE=aio
      - MYSQL_USER=aio
      - MYSQL_PASSWORD=aio
    restart: unless-stopped
```

### Run MariaDB server only
```yml
version: "3.9"
services:
  aio-db:
    image: tdim/aio-server:mariadb
    container_name: aio-db
    volumes:
      - ./db:/run/mysqld
    ports:
      - 3306:3306
    environment:
      - MYSQL_ROOT_PASSWORD=aio # random one every run, if not set
      - MYSQL_DATABASE=aio
      - MYSQL_USER=aio
      - MYSQL_PASSWORD=aio
    restart: unless-stopped
```

### Run Apache and PHP only
```yml
version: "3.9"
services:
  aio-web:
    image: tdim/aio-server:web
    container_name: aio-web
    volumes:
      - ./project:/var/www/htdocs
    ports:
      - 80:80
    restart: unless-stopped
```
