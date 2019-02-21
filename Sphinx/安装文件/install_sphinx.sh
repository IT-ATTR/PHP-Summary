#!/bin/bash
#安装sphinx-2.1.5
cd /usr/local/src
chmod 777 sphinx-2.1.5-release.tar.gz
chmod 777 sphinx-cn.zip
tar -zxf sphinx-2.1.5-release.tar.gz
cd /usr/local/src/sphinx-2.1.5-release
./configure --prefix=/usr/local/sphinx
make && make install
#把sphinx的中文注释的配置文件写到sphinx的etc目录下
cd /usr/local/src
unzip sphinx-cn.zip
cp sphinx.conf /usr/local/sphinx/etc/sphinx.conf
echo "create sphinx.conf succefully"