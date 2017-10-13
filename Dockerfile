FROM rmkn/php7
MAINTAINER rmkn

RUN yum -y install --enablerepo=remi-php71 php-xml php-gd php-zip unzip
RUN curl -o /tmp/grav-skeleton-twenty-site-v1.1.0.zip -SL https://github.com/getgrav/grav-skeleton-twenty-site/releases/download/1.1.0/grav-skeleton-twenty-site-v1.1.0.zip \
        && unzip /tmp/grav-skeleton-twenty-site-v1.1.0.zip -d /var/www/html/ \
        && rm /tmp/grav-skeleton-twenty-site-v1.1.0.zip \
        && mv /var/www/html/grav-skeleton-twenty-site /var/www/html/grav \
        && chmod 777 /var/www/html/grav \
        && chown -R apache. /var/www/html/grav

RUN echo "extension=zip.so" >> /etc/php.ini

COPY vhosts.conf /etc/httpd/conf.d/vhosts.conf

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

