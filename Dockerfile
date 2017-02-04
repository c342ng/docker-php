FROM centos:centos7.1.1503

ENV INSTALL_PATH /opt/php
ENV CONF_PATH /opt/php/conf
ENV DATA_PATH /data/php
ENV LOG_PATH /data/logs/php
ENV PID_PATH /data/run/php-fpm.pid
ENV USER www-data
ENV GROUP www-data

RUN groupadd -r ${GROUP} && useradd -r -g ${GROUP} ${USER}
RUN mkdir -p ${INSTALL_PATH} ${DATA_PATH} ${LOG_PATH} ${CONF_PATH} \
  && chown "${GROUP}:${USER}" ${INSTALL_PATH} ${DATA_PATH} ${LOG_PATH} ${CONF_PATH}
  
RUN rpm --rebuilddb && yum swap -y fakesystemd systemd \
  && yum update --skip-broken && yum install --skip-broken -y ca-certificates curl tar gcc make \
  && yum install -y systemd-devel \
  && yum install -y libxml2-devel zlib-devel && yum install -y \
  openssl-devel curl-devel libjpeg-devel libpng-devel \
  && cd /usr/src/ \
  && curl -Ls http://am1.php.net/get/php-7.1.0.tar.gz/from/this/mirror -o php-7.1.0.tar.gz \
  && tar -xzvf php-7.1.0.tar.gz
  
# RUN cd  /usr/src/php-7.1.0 \
#   && ./configure \
#     --prefix=${INSTALL_PATH} \
#     --with-config-file-path=${INSTALL_PATH}/etc \
#     --with-config-file-scan-dir=${INSTALL_PATH}/etc/php.d \
#     --with-iconv-dir \
#     --with-jpeg-dir \
#     --with-png-dir \
#     --with-zlib \
#     --with-libxml-dir \
#     --enable-xml \
#     --disable-rpath \
#     --enable-bcmath \
#     --enable-shmop \
#     --enable-sysvsem \
#     --enable-inline-optimization \
#     --with-curl \
#     --enable-mbregex \
#     --enable-fpm \
#     --enable-mbstring \
#     --with-gd \
#     --enable-gd-native-ttf \
#     --with-openssl \
#     --with-mhash \
#     --enable-pcntl \
#     --enable-sockets \
#     --with-xmlrpc \
#     --enable-zip \
#     --enable-mbstring \
#     --enable-embed
#  RUN cd  /usr/src/php-7.1.0 && make install && make clean
