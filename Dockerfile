FROM centos:centos7.1.1503

ENV INSTALL_PATH /opt/php
ENV DATA_PATH /data/php
ENV LOG_PATH /data/logs/php
ENV PID_PATH /data/run/php-fpm.pid
ENV USER www-data
ENV GROUP www-data

RUN groupadd -r ${GROUP} && useradd -r -g ${GROUP} ${USER}
RUN mkdir -p ${INSTALL_PATH} ${DATA_PATH} ${LOG_PATH} && chown "${GROUP}:${USER}" ${INSTALL_PATH} ${DATA_PATH} ${LOG_PATH}
RUN yum update --skip-broken && yum install --skip-broken -y ca-certificates curl tar gcc make \
  && cd /usr/src/ \
  && curl -Ls http://am1.php.net/get/php-7.1.0.tar.gz/from/this/mirror -o php-7.1.0.tar.gz \
  && tar -xzvf php-7.1.0.tar.gz \
RUN cd  /usr/src/php-7.1.0 \
  && ./configure --help
