#!/bin/bash
#配置词库
cd /usr/local/src
chmod 777 sphinx-1.3.3.tgz
tar -zxvf sphinx-1.3.3.tgz
cd /usr/local/src/coreseek-3.2.14/csft-3.2.14/api/libsphinxclient
./configure --with-php-config=/usr/bin/php-config --with-sphinx=/usr/local/libsphinxclient
make && make install
#安装php扩展到php5.6当中
cd /usr/local/src/sphinx-1.3.3
phpize
./configure --with-php-config=/usr/bin/php-config
make && make install
cd /etc/php.d
touch 50-sphinx.ini
echo "extension=sphinx.so" > 50-sphinx.ini
echo "please restart apache"