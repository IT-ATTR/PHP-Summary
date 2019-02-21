#!/bin/bash
#配置词库
cd /usr/local/src
chmod 777 coreseek-3.2.14.tar.gz
chmod 777 coreseek-cn.zip
tar -zxvf coreseek-3.2.14.tar.gz
cd /usr/local/src/coreseek-3.2.14/mmseg-3.2.14
echo "chmod 777 bootstrap file"
chmod 777 bootstrap
./bootstrap
./configure --prefix=/usr/local/mmseg3
make && make install
#安装coreseek
cd /usr/local/src/coreseek-3.2.14/csft-3.2.14
chmod 777 buildconf.sh
./buildconf.sh
./configure --prefix=/usr/local/coreseek --without-unixodbc --with-mmseg --with-mmseg-includes=/usr/local/mmseg3/include/mmseg/ --with-mmseg-libs=/usr/local/mmseg3/lib/ --with-mysql
make && make install
#把中文注解的coreseek配置放到coreseek下
cd /usr/local/src
unzip coreseek-cn.zip
cp csft.conf /usr/local/coreseek/etc
echo "create csft.conf successfully"