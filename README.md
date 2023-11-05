# All In One server
All In One server. Apache2+PHP, PHPMyAdmin and MariaDB server on one Alpine Linux docker image.


## Overview
The "aio-server" Docker image is a comprehensive web development environment that simplifies the process of setting up a complete server stack for web applications. This versatile image is built on Alpine Linux (alpine:3.18) and offers multiple tags, each tailored to specific use cases. Whether you need a full-stack web server with Apache, PHP, PHPMyAdmin, and MariaDB or a minimalistic setup with just Apache and PHP.


## Tags

| Tag      | Description                                            |
|----------|--------------------------------------------------------|
| latest   | Includes Apache, PHP, PHPMyAdmin, and MariaDB servers. |
| web      | Includes Apache and PHP only.                          |
| mariadb  | Includes MariaDB server only.                          |
| ubuntu(deprecated)   | Similar to the latest tag but built on Ubuntu 22.04.   |

## Usage

### Pull the Docker Image
You can pull the image from Docker Hub using the following command:

```bash
docker pull tdim/aio-server:tag
```
> Replace "tag" with the desired tag (e.g., latest, mariadb, web, ubuntu).

### Run Containers
Once you've pulled the image, you can run containers with different configurations based on your needs. Below are some basic examples:

- Just for web :
  ```bash
  docker run -rm \
    --name project-web -p 3000:80 \
    -v /path/to/project:/var/www/htdocs \
    tdim/aio-server:web
  ```
- Just for database :
  ```bash
  docker run -rm \
    --name project-db -p 3306:3306 \
    -v /path/to/safe/place/db-data:/run/mysqld \
    tdim/aio-server:mariadb
  ```
- For AMP server with phpmyadmin :
  ```bash
  docker run -rm \
    -name project \
    -p 3000:80 -p 8080:8080 -p 3306:3306 \
    -v /path/to/safe/place/db-data:/run/mysqld \
    -v /path/to/project:/var/www/htdocs \
    tdim/aio-server:latest
  ```
- For Docker compose take a look at [docker-compose.md](https://github.com/Hima-Pro/aio-server/blob/main/docker-compose.md)

### Exposed ports
| Image tag       | Port     | Service                       |
|-----------------|----------|-------------------------------|
| latest, web     | 80       | Apache web server             |
| latest, mariadb | 3306     | MariaDB server                |
| latest          | 8080     | phpmyadmin                    |

### Environment variables

| Image tag        | Variable            | Description                                 |
|------------------|---------------------|---------------------------------------------|
| latest, mariadb  | MYSQL_ROOT_PASSWORD | root password for mariadb                   |
| latest, mariadb  | MYSQL_DATABASE      | database name for mariadb                   |
| latest, mariadb  | MYSQL_USER          | non-global username for mariadb             |
| latest, mariadb  | MYSQL_PASSWORD      | password of the non-global user for mariadb |

### Configuration and data directories
You can customize the container configurations by modifying environment variables, volumes, or other settings as needed. Please refer to the official documentation of each software component (e.g., Apache, PHP, MariaDB) for detailed configuration options.

#### File Tree for /var/www directory with descriptions :
```yml
.
├── aio-logs # logs dir for running servers
├── htdocs # web content dir
├── logs -> /var/log/apache2
├── modules -> /usr/lib/apache2
├── run -> /run/apache2
├── src
│   ├── configs
│   │   ├── php.ini # extra custom php config
│   │   ├── supervisord-mariadb.conf # for the mariadb image
│   │   ├── supervisord-web.conf # for the web image
│   │   └── supervisord.conf # for latest image
│   └── setup
│       ├── mariadb.sh # mysqld script
│       ├── pre-init.d # put .sh scripts here to run before mariadb server runs
│       ├── initdb.d # put .sql or .sql.gz files here to import into db: $MYSQL_DATABASE
│       └── pre-exec.d # put .sh scripts here to run after mariadb server runs
└── supervisord.pid
```
#### Another data directories :
- phpmyadmin installation directory: `/usr/share/webapps/phpmyadmin`
- MariaDB data directory: `/run/mysqld`

## License
This Docker image is distributed under the [MIT License](https://github.com/Hima-Pro/aio-server/blob/main/LICENSE).

## Issues and Contributions
If you encounter issues or would like to contribute to the development of this project, please visit the [Hima-Pro/aio-server](https://github.com/Hima-Pro/aio-server) and create an issue or pull request.
