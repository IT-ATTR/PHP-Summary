# Linux中yum安装mysql5.7

> 最正确的姿势在Linux中yum安装mysql5.7，网上大多数教程都太坑了，为了避免再次踩坑，在这里记录一下安装步骤

### 1.启用MySQL5.7的源

#### 1.1 CentOS6.x 版本方案
```
# 安装MySQL的yum源，下面是RHEL6系列的下载地址  
rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm  

# 安装yum-config-manager  
yum install yum-utils -y  

# 禁用MySQL5.6的源  
yum-config-manager --disable mysql56-community  

# 启用MySQL5.7的源  
yum-config-manager --enable mysql57-community-dmr  

# 用下面的命令查看是否配置正确 如果展示出来的信息显示为5.7则正确
yum repolist enabled | grep mysql  
```

#### 1.2 CentOS7.* 版本方案
```
# 下载mysql源安装包
wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

# 安装mysql源
yum localinstall mysql57-community-release-el7-8.noarch.rpm

# 检查mysql源是否安装成功
yum repolist enabled | grep "mysql.*-community.*"
```
修改vim /etc/yum.repos.d/mysql-community.repo源，改变默认安装的mysql版本。比如要安装5.6版本，将5.7源的enabled=1改成enabled=0。然后再将5.6源的enabled=0改成enabled=1即可。

### 2.关闭Linux子安全系统selinux && 关闭Linux的防火墙机制
> 直接根据我编写 `CentOS6.5服务器部署指南.md` 文章中的配置，这里不做介绍

### 3.安装Mysql
```
[root@localhost ~]# yum -y install mysql mysql-server mysql-devel
```

## 4.启动mysql【重点】
```
# 启动mysqld
service mysqld start  

# 查看mysql自动为你生成的随机密码
grep "password" /var/log/mysqld.log
```
> 2018-03-19T13:28:33.923184Z 1 [Note] A temporary password is generated for root@localhost: `wQ4_dkY:Bgh.`

```
# 使用mysql生成的随机密码登录
mysql -u root -p

# 设置你的新密码
set password=password('新密码');
```
> 注意这里：如果只是修改为一个简单的密码，会报以下错误：
```
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
```
这个其实与`validate_password_policy`的值有关，为了mysql数据库的安全，刚开始设置的密码必须符合长度，且必须含有数字，小写或大写字母，特殊字符。当然这个是可以修改的，不过我可不折腾这个，既然是为了安全，我照做就行，否则自作孽不可活

### 5.填补mysql的中文乱码坑
查看数据库字符集
```
show variables like '%char%';
show variables like '%collation%';
```
设置字符集
```
set character_set_client=utf8;
set character_set_database=utf8;
set character_set_server=utf8;
set collation_server=utf8_unicode_ci;
set collation_database=utf8_unicode_ci;
set collation_connection=utf8_unicode_ci;
```

### 就此，数据库已经安装完成，享受mysql5.7带来的改变吧~
