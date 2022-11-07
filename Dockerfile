FROM ubuntu:18.04
LABEL project="Angola Educa+"
LABEL owner="R2D2"
USER root
ENV TZ=Africa/Lagos
#>>ENV APACHE_RUN_DIR=/var/www/html
RUN apt update -y && apt upgrade -y
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt install clamav clamav-daemon -y
RUN apt install -y wget
RUN apt install -y apache2 apache2-utils
RUN apt install -y software-properties-common
RUN apt install -y ca-certificates
RUN apt install -y lsb-release
RUN apt install -y apt-transport-https
RUN apt install -y php7.2
RUN apt install -y libapache2-mod-php
RUN apt install -y php7.2-common
RUN apt install -y php7.2-mysql
RUN apt install -y php7.2-xml
RUN apt install -y php7.2-xmlrpc
RUN apt install -y php7.2-curl
RUN apt install -y php7.2-gd
RUN apt install -y php7.2-imagick
RUN apt install -y php7.2-cli
RUN apt install -y php7.2-dev
RUN apt install -y php7.2-imap
RUN apt install -y php7.2-mbstring
RUN apt install -y php7.2-opcache
RUN apt install -y php7.2-soap
RUN apt install -y php7.2-zip
RUN apt install -y php7.2-intl
RUN apt install -y mysql-client
RUN rm -rf /var/lib/apt/lists/*
COPY phpinfo.php /var/www/html/
WORKDIR /opt
RUN wget https://download.moodle.org/download.php/direct/stable39/moodle-latest-39.tgz \
    && tar -zxvf moodle-latest-39.tgz \
    && mv moodle /var/www/html/moodle \
    && rm -rf moodle-latest-39.tgz
RUN chown -R www-data:www-data /var/www/html/moodle/
RUN chmod -R 755 /var/www/html/moodle/

#CMD /usr/sbin/httpd -D FOREGROUND
#WORKDIR /var/www/html
#COPY index.html /var/www/html
EXPOSE 80
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#CMD /usr/sbin/apache2 -D FOREGROUND
#CMD service apache2 restart