## Phpmyadmin Dockerfile


This repository is used to build [PhpMyAdmin](http://www.phpmyadmin.net) Docker images.


### Environment Variables

* SERVER_NAME

### Port(s) Exposed

* `80 TCP`


### Base Docker Image

* [inclusivedesign/php](https://github.com/idi-ops/docker-php/)


### Download

    docker pull inclusivedesign/phpmyadmin


#### Run `PhpMyAdmin` (PhpMyAdmin)


```
docker run \
-d \
-p 8081:80 \
--name="phpmyadmin" \
-e "SERVER_NAME=phpmyadmin.test.org" \
inclusivedesign/phpmyadmin
```

### Build your own image


The build system takes the phpmyadmin source stored in `data` directory.

    wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.3.11.1/phpMyAdmin-4.3.11.1-all-languages.tar.gz -O data/phpMyAdmin-all-languages.tar.gz
    docker build --rm=true -t <your name>/phpmyadmin .
