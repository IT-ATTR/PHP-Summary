# yum安装php7
> 亲测 CentOS7.4.1708 版本可行 其他版本有待测试

## 检查当前PHP的安装包
```
[root@localhost ~]# yum list installed | grep php
```
　　
### 完全移除当前PHP安装包以免起冲突
```
[root@localhost ~]# yum remove php*
```

### 默认的yum源无法升级PHP，需要添加第三方yum源，我们选择webtatic库
CentOs 5.x
```
rpm -Uvh http://mirror.webtatic.com/yum/el5/latest.rpm
```
CentOs 6.x
```
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
```
CentOs 7.X
```
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```

### 安装命令
```
[root@localhost ~]# yum install -y php71w-fpm php71w-opcache php71w-cli php71w-gd php71w-imap php71w-mysqlnd php71w-mbstring php71w-mcrypt php71w-pdo php71w-pecl-apcu php71w-pecl-mongodb php71w-pecl-redis php71w-pgsql php71w-xml php71w-xmlrpc php71w-devel mod_php71w
```

## 查看安装版本
```
php -v
```

# 重启apache
```
service httpd restart
```
