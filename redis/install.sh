#!/bin/bash

apt-get install tcl
rm -fr ./redis-4.0.2
wget http://download.redis.io/releases/redis-4.0.2.tar.gz
tar -xzf ./redis-4.0.2.tar.gz
exit 1

cd ./redis-4.0.2
make && make install
make test

mkdir /usr/local/redis

sed -i s/daemonize\ no/daemonize\ yes/g ./redis.conf #让redis-server 支持守护进程启动
sed -i s/dir\ .\//dir\ \/usr\/local\/redis/g ./redis.conf #dump.rdb文件存储位置
cp ./redis.conf /etc/
cd -

#启动redis
redis-server /etc/redis.conf
echo "/usr/local/bin/redis-server /etc/redis.conf" >> /etc/rc.local #开机启动


#安装redis 的PHP扩展
rm -fr ./phpredis-3.1.4
wget https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz --no-check-certificate
tar -zxvf ./3.1.4.tar.gz
cd ./phpredis-3.1.4
phpize
./configure --with-php-config=/andydata/server/php/bin/php-config
make && make install


