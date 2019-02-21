# centos6.5部署

## 通用部署

### 使用yum安装vim

    yum -y install vim

### 防范黑客使用单用户模式破解ROOT密码

生成linux的装载引导密码的Md5加密形式

    grub-md5-crypt
    Password:
    Retype password:
    $1$LcGNm/$Npw4yM1YxGRQnlIsLctXf.

设置装载引导密码到/etc/grub.conf文件当中

    vim /etc/grub.conf

在【splashimage】【hiddenmenu】中间添加引导密码

    splashimage=(hd0,0)/grub/splash.xpm.gz
    password $1$LcGNm/$Npw4yM1YxGRQnlIsLctXf.
    hiddenmenu

### 关闭Linux子安全系统selinux

> selinux是为安全而生,但是由于selinux对于php开发来说是一个好心做坏事的家伙,原因selinux会阻碍ftp,composer,sphinx和redis和memcache,mongdb在php当中的运行,也会阻碍数据库主从同步,因此我们需要把selinux关闭掉

使用vim打开selinux的配置文件

    vim /etc/selinux/config

把Selinux修改为disabled,保存并退出(:x),必须重启linux才能真正关闭Selinux

    SELINUX=disabled

### 配置防火墙

> 详情请查看 centos6防火墙配置.md

清除已有iptables规则

    iptables -F

运行`iptables -L -n`如果内容为空则证明已经规则已经被情况

开放指定的端口

    #允许本地回环接口(即运行本机访问本机)
    iptables -A INPUT -i lo -j ACCEPT
    # 允许已建立的或相关连的通行
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    #允许所有本机向外的访问
    iptables -A OUTPUT -j ACCEPT
    # 允许访问22端口
    iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    #允许访问80端口
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    #允许FTP服务的21和20端口
    iptables -A INPUT -p tcp --dport 21 -j ACCEPT
    iptables -A INPUT -p tcp --dport 20 -j ACCEPT
    #如果有其他端口的话，规则也类似，稍微修改上述语句就行
    #允许ping
    iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    #禁止其他未允许的规则访问
    iptables -A INPUT -j REJECT  #（注意：如果22端口未加入允许规则，SSH链接会直接断开。）
    iptables -A FORWARD -j REJECT

iptables 的开机启动及规则保存 重启防火墙生效

    chkconfig --level 345 iptables on
    service iptables save
    service iptables restart

### 修改Linux系统中的时间

    # 修改系统时间
    date -s 20180326
    date -s 20:03:00
    # 硬件时间同步系统时间
    clock --systohc

## LAMP部署

### 搭建ftp上传和下载环境

> 在Linux当中默认的情况下，我们无法把本地php文件或者其他素材文件上传到linux服务器当中，我们就需要拥有ftp上传工具，ftp拥有上传和下载的功能，有ftp服务器端和ftp客户端两种。

    yum -y install vsftpd

### 使用yum安装Apache

> 如果希望安装Apache服务器的2.0-2.4的版本其实只需要直接运行一下的命令就可以安装,这个版本其实是Centos默认的yum下载的源,所以你不需要做任何的配置工作就能完成,属于比较简单的一个步骤:

    yum -y install httpd httpd-manual mod_ssl mod_perl mod_auth_mysql

### 安装Mysql

> 如果希望安装mysql5.1.73那么直接执行以下命令就会默认安装该版本,因为该版本属于经典的版本因此世界上其实所有的服务器默认都会把这个版本当成首要版本来进行安装,所以安装mysql5.1.73的是一个非常简单的安装过程

    yum -y install mysql mysql-server mysql-devel

### 安装PHP5.6.x

> 在现今的php开发领域,如果我们想脱颖而出那么我们需要懂得nosql的技术和laravel开发框架,然而这些技术不太支持php5.3的版本,因此我们就需要使用php5.6以上版本进行学习和项目部署,所以我们安装的时候就需要安装php5.6

如果你使用了默认的centos进行yum安装php,那么只会安装php5.3的版本,因为centos的默认yum下载源是下载php5.3的,因此在linux当中安装php5.6需要经过以下两个步骤:

    rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm

    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

正式安装PHP5.6.x

    yum -y install --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-pecl-xdebug php-pecl-xhprof

假设如果我们希望在现有的基础上加入一个gd库,我们可以执行命令如下:

    yum -y install --enablerepo=remi --enablerepo=remi-php56 php-gd*

如果现在我们要确定是否安装成功php5.6.x那么执行命令: `php -v`

### 配置和测试lamp环境

> 开启apache服务器必须确认iptables已经关闭并且selinux也已经关闭,否则可能启动不成功。
> apache默认的配置文件在/etc/httpd/conf/httpd.conf当中
> apache默认站点目录在/var/www/html下

apache服务的相关命令:

    service httpd [start | restart | stop | status]

使用vim打开/etc/httpd/conf/httpd.conf

    vim /etc/httpd/conf/httpd.conf

使用末行模式:/ServerName查找到该配置项并修改

    ServerName localhost:80

开启apache服务

    service httpd start

把apache加入开启机脚本

    chkconfig httpd on

在windows中打开浏览器,输入Ip地址,可以访问证明安装成功~

### 测试和配置mysql

启动mysql服务

    service mysqld start

把mysqld加入开机自启动脚本当中:

    chkconfig mysqld on

为mysql的root用户设置初始密码

    mysqladmin -uroot password [密码]

测试root和密码是否可以登录

    mysql -uroot -p[密码]

### 填补mysql的中文乱码坑

使用ftp工具,把mysql的中文乱码MySql脚本上传到/usr/local/src
并将修改脚本文件的权限并执行
```
[root@localhost ~]# cd /usr/local/src
[root@localhost src]# chmod 777 mysql.sh
```
> 由于中文乱码包是一个zip包,必须使用zip和unzip工具解压,因此我们需要安装zip和unzip

执行安装命令和脚本执行命令
```
[root@localhost src]# yum -y install zip unzip
[root@localhost src]# ./mysql.sh
```
重启mysqld服务
```
[root@localhost src]# service mysqld restart
```

查看数据库字符集

```sql
show variables like '%char%';
show variables like '%collation%';
```

设置字符集

```sql
set character_set_client=utf8;
set character_set_database=utf8;
set character_set_server=utf8;
set collation_server=utf8_unicode_ci;
set collation_database=utf8_unicode_ci;
set collation_connection=utf8_unicode_ci;
```
