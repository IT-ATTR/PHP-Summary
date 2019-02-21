## 使用yum安装Lamp
### 第1步:使用yum安装Apache
* 如果希望安装Apache服务器的2.0-2.4的版本其实只需要直接运行一下的命令就可以安装,这个版本其实是Centos默认的yum下载的源,所以你不需要做任何的配置工作就能完成,属于比较简单的一个步骤:

`yum -y install httpd httpd-manual mod_ssl mod_perl mod_auth_mysql`

### 第2步:安装Mysql
* 如果希望安装mysql5.1.73那么直接执行以下命令就会默认安装该版本,因为该版本属于经典的版本因此世界上其实所有的服务器默认都会把这个版本当成首要版本来进行安装,所以安装mysql5.1.73的是一个非常简单的安装过程

`yum -y install mysql mysql-server mysql-devel`

### 第3步:安装PHP5.6.x
* 在现今的php开发领域,如果我们想脱颖而出那么我们需要懂得nosql的技术和laravel开发框架,然而这些技术不太支持php5.3的版本,因此我们就需要使用php5.6以上版本进行学习和项目部署,所以我们安装的时候就需要安装php5.6现实开发当中像37游戏这样的公司,实际上也是使用php5.6比较多.但是问题来了,如果你使用了默认的centos进行yum安装php,那么只会安装php5.3的版本,因为centos的默认yum下载源是下载php5.3的,因此在linux当中安装php5.6需要经过以下两个步骤:

**第1步:配置yum源很简单,只需要简单执行官方给定的php5.6下载源配置即可,分别执行以下两个命令就可以配置yum源,顺序先后执行**

`rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm`

`rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm`

**第2步:安装PHP5.6.x**

* 如果希望安装php5.6必须在yum配置完成后进行,执行以下命令就会完成php5.6最基础和最基本的环境安装,执行以下命令就可以实现php5.6的安装

`yum -y install --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-pecl-xdebug php-pecl-xhprof `

* 假设如果我们希望在现有的基础上加入一个gd库,我们可以执行命令如下,然后重启httpd，然后使用命令: php -v，查看是否安装成功

`yum -y install --enablerepo=remi --enablerepo=remi-php56 php-gd*`

## 配置和测试lamp环境
### 测试和开启apche服务器
* 开启apache服务器必须确认iptables已经关闭并且selinux也已经关闭,否则可能启动不成功

```
apache服务的相关命令:service httpd [start | restart | stop | status]

把apache加入开启机脚本的命令: chkconfig httpd on

apache默认的配置文件在/etc/httpd/conf/httpd.conf当中

apache默认站点目录在/var/www/html下
```

**测试步骤如下:**

* 第1步：使用vim打开/etc/httpd/conf/httpd.conf

* 第2步:使用末行模式:/ServerName

* 修改ServerName如:ServerName localhost:80;然后启动apache服务器

* 使用命令service httpd start启动apache服务器,并且把apache服务器加入开机自启动脚本

`chkconfig httpd on`

* 在windows中打开浏览器,输入Ip地址,出现apache界面,就代表apache配置成功

**测试和配置mysql**

* 第1步:启动mysql服务器使用service mysqld start

* 第2步:为mysql的root用户设置密码使用命令如下:

`mysqladmin -uroot password [密码]`

* 第3步:测试root和密码是否可以登录,使用命令如下

`mysql -uroot -p123456 [数据库]`

**填补mysql的中文乱码坑**

* mysql的中文乱码配置包上传到/usr/local/src下就可以完美解决

* 如果上传不成功,则需要修改/usr/local/src的权限为777

`chmod 777 mysql.sh`

* 由于中文乱码包是一个zip包,必须使用zip和unzip工具解压,因此我们需要安装zip和unzip

` yum -y install zip unzip`

* 我们需要执行shell脚本

`[root@localhost src]./mysql.sh`

**在apache的站点目录中测试php的版本是否为php5.6.x**

* apache安装完成后,在linux中有一个默认的站点目录在/var/www/html下,于是我们把编写好的php文件(phpinfo.php)上传到该目录中,其中代码如下

`phpinfo()`


