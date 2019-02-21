# XtraBackup备份

## 安装Percona存储库
访问https://www.percona.com/downloads/XtraBackup/LATEST/
获取相应版本的下载地址
```
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm
```
测试储存库
```
yum list | grep percona
```
您应该看到类似于以下内容的输出：
```
...
percona-xtrabackup-20.x86_64                2 .0.8-587.rhel5 percona-release-x86_64
percona-xtrabackup-20-debuginfo.x86_64      2 .0.8-587.rhel5 percona-release-x86_64
percona-xtrabackup-20-test.x86_64           2 .0.8-587.rhel5 percona-release-x86_64
percona-xtrabackup-21.x86_64                2 .1.9-746.rhel5 percona-release-x86_64
percona-xtrabackup-21-debuginfo.x86_64      2 .1.9-746.rhel5 percona-release-x86_64
percona-xtrabackup-22.x86_64                2 .2.13-1.el5 percona-release-x86_64
percona-xtrabackup-22-debuginfo.x86_64      2 .2.13-1.el5 percona-release-x86_64
percona-xtrabackup-debuginfo.x86_64         2 .3.5-1.el5 percona-release-x86_64
percona-xtrabackup-test.x86_64              2 .3.5-1.el5 percona-release-x86_64
percona-xtrabackup-test-21.x86_64           2 .1.9-746.rhel5 percona-release-x86_64
percona-xtrabackup-test-22.x86_64           2 .2.13-1.el5 percona-release-x86_64
...
```
安装 libev软件包
```
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
```
执行安装
```
yum install percona-xtrabackup-24
```

## 全量备份
```
innobackupex --user=管理员账号 --password=密码 --parallel=2 备份路径

innobackupex --user=backup --password=Gzjunyu19970925. --parallel=2 /home/db_backup/
```
## 全量恢复
建议恢复前停止mysql服务，且清空mysql数据文件
```
innobackupex --datadir=mysql数据路径 --copy-back 备份路径

innobackupex --datadir=/var/lib/mysql --copy-back /home/db_backup/2018-04-21_10-44-22/
```
修改mysql数据路径的权限为777
```
chmod -R 777 /var/lib/mysql
```
