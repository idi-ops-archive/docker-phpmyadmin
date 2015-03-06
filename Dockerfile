FROM inclusivedesign/php:5.4

ADD start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh && \
	yum -y install php-mbstring tar wget && \
	wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.3.11.1/phpMyAdmin-4.3.11.1-all-languages.tar.gz -O /var/phpMyAdmin-all-languages.tar.gz
	cd /var && tar xf /var/phpMyAdmin*.tar.gz && \
    mv /var/phpMyAdmin-all-languages.tar.gz /var/www/ && \
    rm -fr /var/phpMyAdmin-all-languages.tar.gz && \
    yum -y remove tar wget && \
    yum -y clean all && \
    cd /var/www && rm -rf *.md .coveralls.yml ChangeLog composer.json config.sample.inc.php DCO doc examples phpunit.* README RELEASE-DATE-* setup

EXPOSE 80

CMD ["/usr/local/bin/start.sh"]
