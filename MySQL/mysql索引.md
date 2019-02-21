# mysql索引

## 主键索引建立
建立字段自增
```
Alter table 表名 modify 字段名 字段类型 auto_increment
```

建立主键索引
```
alter table 表名 add primary key(字段名称)
```

删除主键索引
```
Alter table 表名 drop primary key;
```

删除字段自增
```
alter table 索引名 modify id int unsigned;
```

## 唯一索引

创建唯一索引
```
create unique index 索引的名称 on 表名(字段名称)
```

删除唯一索引
```
alter table 表名 drop index 索引的名称
```

## 普通索引
创建普通索引
```
create index 索引的名称 on 表名(字段名称);
```
删除普通索引
```
alter table 表名 drop index 索引的名称
```

## 前缀索引
创建前缀索引
```
alter table 表名 add index 索引名称（字段名称(长度)）
```
删除前缀索引
```
alter table 表名 drop index 索引名称
```

查询执行计划
```
explain sql语句
```
