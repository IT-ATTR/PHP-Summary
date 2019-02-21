# mysqldump 逻辑备份

## 常用命令
```cmd
/* 指定数据库多个表进行备份 */
mysqldump [OPTIONS] database [table];

/* 指定多个数据库备份 */
mysqldump [OPTIONS] database [OPTIONS] DB1 DB2;

/* 整个数据库实例进行备份 */
mysqldump [OPTIONS] --all-database [OPTIONS];
```

## 常用参数
|参数|描述|
|-- | --|
|`--single-transaction`|开启事务保证备份数据的完整性【innodb特有】|
|`-l` `--lock-tables`|依次锁定备份数据库所有表保证备份数据的完整性|
|`-x` `--lock-all-table`|一次性锁定整个数据库实例所有数据表保证数据完整性|
|`--master-data=[1/2]`|CHANGE MASTER TO 语句会被写成一个sql注释 1不会被写成注释 2写成注释 默认1|
|`-R` `--routines`|备份数据库存储过程|
|`--triggers`|备份数据库触发器|
|`-E` `--events`|备份数据库调度事件|
|`--hex-blob`|16进制导出bit列和blob列数据 避免数据文本不可见|
|`--tab=path`|指定路径下为每个数据库生成两个文件（数据结构、数据）|
|`-w` `--where=过滤条件`|过滤指定数据【仅支持单表导出】|

> 数据表锁定后只能进行读操作

> `--single-transaction` `--lock-tables` 参数是互斥的，所以，如果同一个数据库下同时存在innodb表和myisam表只能使用`--lock-tables`来保证备份数据的一致性，但是`--lock-tables`只能保证某一备份数据库的完整性，不能保证整个实例备份的完整性

### 实例
```sql
mysqldump -ubackup -p --master-data=2 --single-transaction --routines --triggers --events 数据库 > 备份文件.sql
```

### 查看备份
```
more 备份文件.sql

grep 'CREATE TABLE' 备份文件.sql
```


## 使用`--tab=path`进行备份
赋予备份管理员写入文件新的权限
```
grant file on *.* to 'backup'@'localhost';
```
备份
```

```
