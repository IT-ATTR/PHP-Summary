# mysql分区表

# 查看是否支持分区表
```sql
show plugins;
```

## 范围分区相关操作
```sql
-- 新建范围分区表
CREATE TABLE `表名`(
    -- 数据字段
)engine=INNODB
PARTITION BY RANGE(`字段名称`) (
    PARTITION 分表名称 VALUES LESS THAN(范围),
    PARTITION 分表名称 VALUES LESS THAN(范围)
);

-- 新建哈希分区表
create table `表名`(
    -- 数据字段
)engine=INNODB
PARTITION BY HASH(UNIX TIMESTAMP(`字段名称`)) PATITIONS 4;

-- 新建时间分区
create table `表名`(
    -- 数据字段
)engine=INNODB
PARTITION BY RANGE(YEAR(`字段名称`))(
    PARTITION p0 VALUES LESS THAN(2017),
    PARTITION p1 VALUES LESS THAN(2018),
    PARTITION p2 VALUES LESS THAN(2019)
);
```
## 添加分区
```sql
CREATE TABLE `表名` ADD PARTITION (
    PARTITION 分表名称 VALUES LESS THAN(范围)
);
```
## 删除分区
```sql
ALTER TABLE `表名` DROP PARTITION 分表名称;
```

## 查看分区表情况
```sql
SELECT
    table_name,partition_name,partition_description,table_rows
FROM
    information_schema.`PARTITIONS`
WHERE table_name = '表名';
```

# 将分区表数据归档(mysql>=5.7)
```sql
-- 分区归档操作步骤
-- 1.新建和分区表字段一致的数据表 归档表前缀为 arch_
CREATE TABLE `归档表表名`(

)engine=INNODB
-- 2.进行数据交换 p0为分区名
ALTER TABLE `原数据表表名` exchange PARTITION p0 WITH TABLE `归档表表名`;
-- 3.删除分区，避免对数据的再次写入
ALTER TABLE `原数据表表名` DROP PARTITION p0;
-- 4.将归档表引擎设置为 archive  在检表语句中mysql引擎必须和原数据表引擎一致，否则无法进行数据交换
ALTER TABLE `归档表表名` ENGINE=ARCHIVE;
```
