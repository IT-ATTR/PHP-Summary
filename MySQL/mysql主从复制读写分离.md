# mysql主从复制读写分离

## 授权远程访问mysql数据库

准备工作：新建相关数据库管理员，授权并开启远程访问权限

```sql
-- 建议新建一个备份和主从复制的数据库管理员
CREATE USER 'backup'@'localhost' IDENTIFIED BY '密码';
-- 分配相关权限
grant select,reload,lock tables,replication client,show view,event,process on *.* to 'backup'@'localhost';
-- 开启远程访问权限
GRANT ALL PRIVILEGES ON *.* TO 授权用户名@被授权服务器的IP IDENTIFIED BY '授权密码';
FLUSH PRIVILEGES;
```

需要在master服务器和slave服务器都建立一个同名的数据(备份数据库)

在主服务器中开启binlog日志和设置要发生主从同步数据库,使用vim打开/etc/my.cnf文件,修改配置如下

```
#mysql的bin-log日志配置选项,假设做读写（主从），这个选项在从服务器必须关闭
log_bin = binlog
#端口信息，其实可以不写
port = 3306
#主服务器的id,这id不一定设为1，只要主从不一样就行
server-id = 1
#要做同步的数据库名字，可以是多个数据库，之间用分号分割。
binlog_do_db = test
```

重启mysqld服务器
```bash
[root@localhost ~]# service mysqld restart;
```

登录mysql查看binlog日志相关参数是否正确
```sql
show master status;
show variables like 'log_bin';
```

主服务器已经配置成功，这时要切换到从服务器开始配置

在从服务器中开启binlog日志和设置要发生主从同步数据库,使用vim打开/etc/my.cnf文件,修改配置如下
```
#从服务器的id,必须与主服务器的id是不同
server-id = 2
#主服务器的ip地址
master-host = 192.168.56.2
#grant授权的可复制用户账号
master-user = backup
#grant授权的可复制密码
master-password = 123456
#主服务器的mysql端口
master-port = 3306
#这个参数是用来设置在和主服务器连接丢失的时候，重试的时间间隔，默认是60秒
master-connect-retry = 20
#需要同步的主服务器数据库
replicate-do-db = test
```
登录mysql执行如下方法
```sql
show slave status\G

-- 如果结果包含如下参数，则证明主从已经配置成功
Slave_IO_Running: Yes
Slave_SQL_Running: Yes
```
