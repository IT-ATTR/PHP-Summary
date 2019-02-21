# 用户权限管理与mysql备份

## 用户权限管理

### 查看用户信息

> mysql将用户保存到mysql数据库的user表中

```sql
use mysql;
-- msyql 5.7安全机制无法查看password
select host,user,password from user where 1;
```

### 新增用户

```sql
create user '账号'@'IP地址' identified by '密码';
-- 示例
create user 'zjlsp'@'localhost' identified by '123456';
```

### 修改用户的密码

```sql
-- root账号修改其他账号密码
set password for '账号'@'IP地址' = password('密码');
-- 修改自己的密码
set  password=password('密码');
-- 通过修改表数据直接修改密码（不推荐）
update user set password=password('123456') where user='zjlsp';
```

### 删除用户

```sql
drop user '账号'@'IP地址';
```

### 为用户授权操作

```sql
grant 权限1[, 权限2, …, 权限n] on 库名.表名 to '账号'@'IP地址';
```

### 收回权限

```sql
revoke 权限1[, 权限2, …, 权限n] on 库名.表名 from '账号'@'IP地址';
```

### 查看给已有用户分配的权限

```sql
show grants for '账号'@'IP地址';
```

| 权限                      | 权限级别        | 权限说明           |
| ----------------------- | ----------- | -------------- |
| CREATE                  | 数据库表或索引     | 创建数据库、表或索引权限   |
| DROP                    | 数据库或表       | 删除数据库或表权限      |
| GRANT OPTION            | 数据库表或保存的程序  | 赋予权限选项         |
| REFERENCES              | 数据库或表       |                |
| ALTER                   | 表           | 更改表，比如添加字段、索引等 |
| DELETE                  | 表           | 删除数据权限         |
| INDEX                   | 表           | 索引权限           |
| INSERT                  | 表           | 插入权限           |
| SELECT                  | 表           | 查询权限           |
| UPDATE                  | 表           | 更新权限           |
| SHOW VIEW               | 视图          | 查看视图权限         |
| ALTER ROUTINE           | 存储过程        | 更改存储过程权限       |
| CREATE ROUTINE          | 存储过程        | 创建存储过程权限       |
| EXECUTE                 | 存储过程        | 执行存储过程权限       |
| FILE                    | 服务器主机上的文件访问 | 文件访问权限         |
| CREATE TEMPORARY TABLES | 服务器管理       | 创建临时表权限        |
| LOCK TABLES             | 服务器管理       | 锁表权限           |
| CREATE USER             | 服务器管理       | 创建用户权限         |
| PROCESS                 | 服务器管理       | 查看进程权限         |
| RELOAD                  | 服务器管理       |                |
| REPLICATION CLIENT      | 服务器管理       | 复制权限           |
| REPLICATION SLAVE       | 服务器管理       | 复制权限           |
| SHOW DATABASES          | 服务器管理       | 查看数据库权限        |
| SHUTDOWN                | 服务器管理       | 关闭数据库权限        |
| SUPER                   | 服务器管理       | 执行kill线程权限     |

## 使用mysqldump进行备份

### 基本命令

```bash
# 备份指定数据库下的指定表
[root@localhost ~]# mysqldump [OPTIONS] database [table]
# 备份多个数据库
[root@localhost ~]# mysqldump [OPTIONS] --database [OPTIONS] DB1 [DB2 DB3]
# 备份整个mysql实例下的所有表
[root@localhost ~]# mysqldump [OPTIONS] --all-database [OPTIONS]
```

### 基本参数[OPTIONS]

| 参数                       | 描述                                              |
| ------------------------ | ----------------------------------------------- |
| `-u`                     | 数据库管理员账号                                        |
| `-p`                     | 数据库管理员密码                                        |
| `--single-transaction`   | 通过事务监控备份数据的一致性【innodb】                          |
| `-l` `--lock-tables`     | 锁定备份数据库下的所有表，仅允许读操作【innodb无需使用该参数】              |
| `-x` `--lock-all-tables` | 锁定整个数据库实例下的所有数据库的所有表                            |
| `--master-data=[1/2]`    | 1:包括CHANGE MASTER TO这个语句 2:注释CHANGE MASTER TO语句 |
| `-R` `--routines`        | 备份数据库中存在的存储过程                                   |
| `--triggers`             | 备份数据库存在的触发器                                     |
| `-E` `--events`          | 备份数据库存在的调度事件                                    |
| `--hex-blob`             | 以16进制导出blob字段数据                                 |
| `--tab=path`             | 在指定的目录下生成表结构和表数据                                |
| `-w` `--where='过滤条件'`    | 导出指定条件的数据【单表导出】                                 |

### 导出的语句

```bash
[root@localhost ~]# mysqldump -uroot -p --master-data=2 --single-transaction --routines --triggers --events index Innodb_yes > index_innodb_yes.sql
```
