#!/bin/bash

app_name=php

user=php-fpm
group=php

data_folders=""

#user & group
egrep "^$group" /etc/group >& /dev/null
if [ $? -ne 0 ]
then
    groupadd $group
fi

#create user if not exists  
egrep "^$user" /etc/passwd >& /dev/null
if [ $? -ne 0 ]
then
    useradd -g $group --shell=/sbin/nologin $user
fi

#log
if [ ! -d "/data/logs/${app_name}/" ]; then
     mkdir -p /data/logs/${app_name}/
     chown ${user}:${group} /data/logs/${app_name}/
fi


#pid
if [ ! -d "/data/run" ]; then
  mkdir -p /data/run
fi

for folder in $data_folders
  do
    echo ${folder}
    if [ ! -d "${folder}" ]; then
      mkdir -p ${folder}
      chown ${user}:${group} ${folder}
    fi
  done
