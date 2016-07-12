FROM centos:6
MAINTAINER rmkn
RUN yum -y update
RUN yum -y install epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y install --enablerepo=remi,remi-php70 httpd php70-php php70-php-mbstring php70-php-xml php70-php-gd unzip
RUN ln -s /usr/bin/php70 /usr/bin/php
RUN curl -o /tmp/grav-skeleton-twenty-site-v1.1.0.zip -SL https://github.com/getgrav/grav-skeleton-twenty-site/releases/download/1.1.0/grav-skeleton-twenty-site-v1.1.0.zip \
        && unzip /tmp/grav-skeleton-twenty-site-v1.1.0.zip -d /var/www/html/ \
        && rm /tmp/grav-skeleton-twenty-site-v1.1.0.zip \
        && mv /var/www/html/grav-skeleton-twenty-site /var/www/html/grav \
        && chmod 777 /var/www/html/grav \
        && chown -R apache. /var/www/html/grav

EXPOSE 80
COPY vhosts.conf /etc/httpd/conf.d/vhosts.conf
COPY security.conf /etc/httpd/conf.d/security.conf
COPY init.sh /tmp/init.sh
RUN /tmp/init.sh && rm /tmp/init.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

