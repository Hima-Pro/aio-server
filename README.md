# All In One server
All In One server. apache2, php, phpmyadmin and mariadb in one Alpine Linux docker image.

## Overview
The "aio-server" Docker image is a comprehensive web development environment that simplifies the process of setting up a complete server stack for web applications. This versatile image is built on Alpine Linux (alpine:3.20) and offers multiple tags, each tailored to specific use cases. Whether you need a full-stack web server with Apache, PHP, PHPMyAdmin, and MariaDB or a minimalistic setup with just Apache and PHP.

## Tags

| Tag      | Description                                            |
|----------|--------------------------------------------------------|
| latest   | Includes Apache, PHP, PHPMyAdmin, and MariaDB servers. |
| web      | Includes Apache and PHP only.                          |
| mariadb  | Includes MariaDB server only.                          |

## Usage

### Pull the Docker Image
You can pull the image from Docker Hub using the following command:

```bash
docker pull tdim/aio-server:tag
```
> Replace "tag" with the desired tag (e.g., latest, mariadb, web).

### Run Containers
Once you've pulled the image, you can run containers with different configurations based on your needs. Below are some basic examples:

- Just for web :
  ```bash
  docker run -rm --name project-web -p 3000:80 -v /path/to/project:/var/www/localhost/htdocs tdim/aio-server:web
  ```
- Just for database :
  ```bash
  docker run -rm --name project-db -p 3306:3306 -v /path/to/safe/place/db-data:/run/mysqld tdim/aio-server:mariadb
  ```
- For AMP server with phpmyadmin :
  ```bash
  docker run -rm -name project -p 3000:80 -p 8080:8080 -p 3306:3306 -v /path/to/safe/place/db-data:/run/mysqld -v /path/to/project:/var/www/localhost/htdocs tdim/aio-server:latest
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
| latest, mariadb  | MYSQL_ROOT_PASSWORD | Default root password for mariadb           |

### Configuration and data directories
You can customize the container configurations by modifying environment variables, volumes, or other settings as needed. Please refer to the official documentation of each software component (e.g., Apache, PHP, MariaDB) for detailed configuration options.

## Important data directories :
- `/app` for logs, pid files and configs
- `/usr/share/webapps/phpmyadmin` phpmyadmin installation directory
- `/run/mysqld` MariaDB data directory

## License
This Docker image is distributed under the [MIT License](https://github.com/Hima-Pro/aio-server/blob/main/LICENSE).

## Issues and Contributions
If you encounter issues or would like to contribute to the development of this project, please visit the [Hima-Pro/aio-server](https://github.com/Hima-Pro/aio-server) and create an issue or pull request.
