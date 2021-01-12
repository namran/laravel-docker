FROM amazonlinux

WORKDIR /var/www

RUN yum -y update && \
    yum install -y amazon-linux-extras && \
    /usr/bin/amazon-linux-extras enable php7.4 && \
    yum clean metadata && \
    yum -y install php-cli php-pdo php-fpm php-json php-mysqlnd && \
    yum -y install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} && \
    yum -y install httpd python3 python3-pip which tree curl  procps && \
    /usr/bin/amazon-linux-extras install epel && \
    yum -y install nodejs npm && \
    # Clean up
    yum clean all && \
    rm -rf /var/cache/yum
RUN pip3 install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf && \
    # Install composer
    /usr/bin/curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 80

CMD ["/usr/sbin/httpd","-DFOREGROUND"]
