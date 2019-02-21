# 关于Innodb和MyISAM时间类型速度测试

>测试环境：
mysql 5.7 centos 7.4 单核cpu 1G内存

## 建表语句
```sql
create table Innodb_yes(
    `id` int unsigned auto_increment primary key not null,
    `add_int` int not null default 0 comment '时间戳',
    `add_time` timestamp not null default current_timestamp comment '时间日期'
)engine=innodb comment 'innodb优化表';
ALTER TABLE `Innodb_yes` ADD INDEX( `add_int` );
ALTER TABLE `Innodb_yes` ADD INDEX( `add_time` );

create table Innodb_no(
    `id` int unsigned auto_increment primary key not null,
    `add_int` int not null default 0 comment '时间戳',
    `add_time` timestamp not null default current_timestamp comment '时间日期'
)engine=innodb comment 'innodb普通表';

create table MyISAM_yes(
    `id` int unsigned auto_increment primary key not null,
    `add_int` int not null default 0 comment '时间戳',
    `add_time` timestamp not null default current_timestamp comment '时间日期'
)engine=innodb comment 'MyISAM优化表';
ALTER TABLE `MyISAM_yes` ADD INDEX( `add_int` );
ALTER TABLE `MyISAM_yes` ADD INDEX( `add_time` );

create table MyISAM_no(
    `id` int unsigned auto_increment primary key not null,
    `add_int` int not null default 0 comment '时间戳',
    `add_time` timestamp not null default current_timestamp comment '时间日期'
)engine=innodb comment 'MyISAM普通表';
```

## 制造假数据
```sql
delimiter //
drop procedure per//
create procedure per()
begin
declare num int;
declare timeData int;
declare dateTime int;
set num=0;
set timeData = 1514736000;
while num < 10000000 do
set timeData = timeData+1;
insert into `MyISAM_no`(add_int,add_time) values(timeData,from_unixtime(timeData));
set num=num+1;
end while;
end
//
delimiter ;
call per();
drop procedure per;
```

## 记录查询速度
### 测试MyISAM
```sql
# 查询出 2018-01-10 一天内的所有数据
SELECT count(id) FROM `MyISAM_no` WHERE add_int>= 1515168000 AND add_int< 1515254400;
SELECT count(id) FROM `MyISAM_no` WHERE add_time >= '2018-01-06 00:00:00' AND add_time< '2018-01-07 00:00:00';
SELECT count(id) FROM `MyISAM_yes` WHERE add_int>= 1515168000 AND add_int< 1515254400;
SELECT count(id) FROM `MyISAM_yes` WHERE add_time >= '2018-01-06 00:00:00' AND add_time< '2018-01-07 00:00:00';
```
#### mysql5.1测试结果

|查询方法|int(无索引)|timestamp(无索引)|int(有索引)|timestamp(有索引)|
|------------ | -------------|
|执行时间|5.29 sec|9.19 sec|0.41 sec|0.09 sec|
|查询结果|86400|86400|86400|86400|
|type|ALL|ALL|range|range|
|possible_keys|(NULL)|(NULL)|add_int|add_time|
|key|(NULL)|(NULL)|add_int|add_time|
|rows|10000468|10000468|173232|173232|

#### mysql5.7测试结果

|查询方法|int(无索引)|timestamp(无索引)|int(有索引)|timestamp(有索引)|
|------------ | -------------|
|执行时间|3.83 sec|15.25 sec|0.57 sec|0.16 sec|
|查询结果|86400|86400|86400|86400|
|type|ALL|ALL|range|range|
|possible_keys|(NULL)|(NULL)|add_int|add_time|
|key|(NULL)|(NULL)|add_int|add_time|
|rows|9982277|9982277|167730|167730|
### 测试Innodb
```sql
# 查询出 2018-01-10 一天内的所有数据
SELECT count(id) FROM `Innodb_no` WHERE add_int>= 1515168000 AND add_int< 1515254400;
SELECT count(id) FROM `Innodb_no` WHERE add_time >= '2018-01-06 00:00:00' AND add_time< '2018-01-07 00:00:00';
SELECT count(id) FROM `Innodb_yes` WHERE add_int>= 1515168000 AND add_int< 1515254400;
SELECT count(id) FROM `Innodb_yes` WHERE add_time >= '2018-01-06 00:00:00' AND add_time< '2018-01-07 00:00:00';
```
#### mysql5.1测试结果
|查询方法|int(无索引)|timestamp(无索引)|int(有索引)|timestamp(有索引)|
|------------ | -------------|
|执行时间|5.71 sec|9.65 sec|0.14 sec|0.09 sec|
|查询结果|86400|86400|86400|86400|
|type|ALL|ALL|range|range|
|possible_keys|(NULL)|(NULL)|add_int|add_time|
|key|(NULL)|(NULL)|add_int|add_time|
|rows|9981346|9981346|167730|167730|

#### mysql5.7测试结果
|查询方法|int(无索引)|timestamp(无索引)|int(有索引)|timestamp(有索引)|
|------------ | -------------|
|执行时间|3.60 sec|15.05 sec|0.05 sec|0.17 sec|
|查询结果|86400|86400|86400|86400|
|type|ALL|ALL|range|range|
|possible_keys|(NULL)|(NULL)|add_int|add_time|
|key|(NULL)|(NULL)|add_int|add_time|
|rows|9981346|9981346|167730|167730|

## 总结
在innodb存储引擎中使用int类型且存在索引的情况下具有更好的执行效率，其次是innodb存储引擎中使用timestamp类型且存在索引的情况。

综合建议，如果需要更快的时间查询，建议使用int,如果需要更加友好的可视化界面，使用timestamp类型并添加索引，如果不允许建立索引的情况下，必须使用int类型，timestamp类型在无索引情况下的查询效率十分慢！！！
