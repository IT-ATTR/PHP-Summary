# sql文件恢复

## 全量恢复
```
mysql -uroot -p 数据库 < sql文件
```

## 基于时间点的恢复
首先进行一次基于最近一次的全量备份的文件进行一次全量恢复
```
mysql -uroot -p 数据库 < sql文件
```
然后查看备份的sql文件的 CHANGE MASTER 值，基于该值进行二进制日志的还原
```
CHANGE MASTER TO MASTER_LOG_FILE='binlog.000007', MASTER_LOG_POS=154;
```
查看二进制日志,根据时间点找到误操作前一段时间的二进制日志
```
cd /var/lib/mysql

mysqlbinlog --base64-output=decode-rows -vv --start-position=154 --database=数据库名 binlog.000008 | grep -B3 DELETE | more
```

记录最早删除记录的节点值，执行日志导出
```
mysqlbinlog --start-position=开始节点 --stop-position=结束节点 --database=数据库 二进制日志名 > 导出的sql文件名

mysqlbinlog --start-position=154 --stop-position=26158 --database=laravel binlog.000007 > laravel.sql
```

对导出的sql文件进行全量的还原
```
mysql -uroot -p 数据库 < sql文件
```
