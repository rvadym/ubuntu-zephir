FROM ubuntu:16.04
MAINTAINER RVadym

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV TERM xterm

# Our user in the container
USER root
WORKDIR /root

# Need to generate our locale.
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# ----------------------------------------------------------------------
#
#                           INSTALL SOFTWARE
#
# ----------------------------------------------------------------------

RUN apt-get update && apt-get install -y curl \
                      php7.0-common php7.0-cli php7.0-fpm \
                      php7.0-mysql php7.0-curl php7.0-gd php7.0-intl php-pear php-imagick \
                      php7.0-imap php7.0-mcrypt php-memcache  php7.0-pspell php7.0-recode \
                      php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-mbstring \
                      php-gettext php7.0-pgsql \

                      nodejs npm \

                      apache2 libapache2-mod-php7.0 php-xdebug \
                      git vim htop bmon git wget unzip \
                      sudo gcc make re2c libpcre3-dev php7.0-dev build-essential php7.0-zip && \



    # Tidy up
    apt-get -y autoremove && apt-get clean && apt-get autoclean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

    # Install composer
    curl https://getcomposer.org/installer | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

RUN git clone https://github.com/phalcon/zephir && cd zephir && ./install -c


# INSTALL SOFTWARE ----------------------------------------------------------------------



# Allow mounting files
VOLUME ["/app"]