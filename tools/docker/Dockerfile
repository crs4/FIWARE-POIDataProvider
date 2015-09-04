#----------------------------------------------------
#
# A machine configured following
# http://forge.fiware.org/plugins/mediawiki/wiki/fiware/index.php/POI_Data_Provider_-_Installation_and_Administration_Guide
#----------------------------------------------------
FROM ubuntu:latest
#----------------------------------------------------
RUN \
    apt-get install -y wget && \
    echo "deb http://apt.postgresql.org/pub/repos/apt trusty-pgdg main" >> /etc/apt/sources.list && \
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -  && \
    apt-get update && \
    apt-get install -y \
        apache2 \
        gcc git \
        libpcre3-dev libcurl3 libcurl4-openssl-dev \
        make mongodb \
        openssh-server \
        php5 php5-pgsql php-pear php-http php5-dev \        
        postgresql-9.4-postgis-2.1 pgadmin3 postgresql-contrib
        

RUN \
    mkdir -p /etc/php5/conf.d && \
    mkdir -p /etc/php5/apache2 && \    
    echo "extension=propro.so" >> /etc/php5/apache2/php.ini && \
    echo "extension=raphf.so" >> /etc/php5/apache2/php.ini && \
    echo "extension=http.so" >> /etc/php5/apache2/php.ini && \
    echo "extension=mongo.so" >> /etc/php5/apache2/php.ini && \
    echo "extension=propro.so" >> /etc/php5/cli/php.ini && \
    echo "extension=raphf.so" >> /etc/php5/cli/php.ini && \
    echo "extension=http.so" >> /etc/php5/cli/php.ini && \
    echo "extension=mongo.so" >> /etc/php5/cli/php.ini && \
    pecl install propro && \
    pecl install raphf  && \
    pecl install pecl_http-1.7.6 && \
    pecl install mongo 
    

#----------------------------------
# Enable sshd
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
EXPOSE 80

#-----------------------------------
CMD ["/usr/sbin/sshd", "-D"]

    
    

