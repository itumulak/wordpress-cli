#  wordpress-cli
This image uses the [official wordpress docker image](https://github.com/docker-library/wordpress/tree/047c3b4b0f54f80753e65c20dcc0064b0d39a76b/php7.1/apache) and then rebuild to bundle with WordPress CLI and other software packages. **For Development use only!** Do not ship in production but instead use the [official image](https://hub.docker.com/_/wordpress) or better its alphine version.  

##### The following packages that where added:
- WP CLI
- vim
- curl
- git
- zsh with oh-my-zsh
- pygments

## Usage
### Start a container with Docker
```
docker run -it --name your-container-name -p 80:80 -d itumulak/wordpress-cli
```

### Creating your stack with docker-compose
Create a YML file.
```yaml
version: '2'

services:
   db:
     image: mysql:5.7
     volumes:
       - ./db:/docker-entrypoint-initdb.d
       - ./db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: root
       MYSQL_DATABASE: wordpress

       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     image: itumulak/wordpress-cli:latest
     volumes:
        - ./www:/var/www/html
     ports:
       - 80:80
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress

   phpmyadmin:
    depends_on:
      - db
    image: phpmyadmin/phpmyadmin
    restart: always
    ports:
      - 8000:80
    environment:
      PMA_HOST: db
      MYSQL_ROOT_PASSWORD: root
volumes:
    db_data:
```
Then:
```
docker-compose up
```

### Bash into the container with zsh
```
docker exec -it your-container-name zsh
```

### Executing WP CLI commands
```
docker exec -it your-container-name wp --allow-root --info
```
For a full list of the commands check their [documentation](https://wp-cli.org/cli/commands/).