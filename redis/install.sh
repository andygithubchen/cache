#!/bin/bash

#apt-get install tcl
#rm -fr ./redis-4.0.2
#wget http://download.redis.io/releases/redis-4.0.2.tar.gz
#tar -xzf ./redis-4.0.2.tar.gz
#cd ./redis-4.0.2
#make && make install
#make test

#
#mkdir /usr/local/redis

#sed -i s/daemonize\ no/daemonize\ yes/g ./redis.conf #让redis-server 支持守护进程启动
#cp ./redis.conf /etc/
#cd -

#启动redis
#redis-server /etc/redis.conf
#echo "/usr/local/bin/redis-server /etc/redis.conf" >> /etc/rc.local #开机启动


#安装redis 的PHP扩展
#rm -fr ./phpredis-3.1.4
#wget https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz --no-check-certificate
#tar -zxvf ./3.1.4.tar.gz
cd ./phpredis-3.1.4
phpize
./configure --with-php-config=/andydata/server/php/bin/php-config
make && make install



#php 操作redis有两种主流的方式：
#1. 使用redis 的PHP扩展(推荐)
#  扩展地址：https://github.com/phpredis/phpredis
#  中文文档：http://www.runoob.com/redis/redis-php.html
#  两个可以对照着看，一个中文，一个英文，方便找方法
#2. 不使用redis 的PHP扩展，使用这个的使用就不用：https://github.com/nrk/predis (这个重要是不知道有些什么方法，以及怎么用)



#翻译整理conf文件

#Redis GUI 管理工具

