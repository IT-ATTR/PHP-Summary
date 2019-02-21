# mysql高级查询语法

## 子语句
`where`条件语句
```sql
select * from table where 1;
```
`roup by`分组统计
```sql
-- 相同的数据只会显示一条
select * from table where 1 group by name;
```
`having`附属条件语句
```sql
select * from table where 1 having name='xxx';
```
`order by`排序
```sql
--升序排列
select * from table where 1 order by id;
select * from table where 1 order by id asc;
-- 降序排列
select * from table where 1 order by id desc;
```
`limit`查询条数
```sql
-- 查询两条数据
select * from table where 1 limit 2;
-- 跳过4条数据，查询两条数据
select * from table where 1 limit 4,2;
```

## 聚合函数

| 函数名        | 描述                           |
| ---------- | ---------------------------- |
| `count()`  | 统计指定字段在表中的记录总条数，不统计null值。    |
| `max()`    | 统计指定字段数据的最大值。                |
| `min()`    | 统计指定字段数据的最小值。                |
| `avg()`    | 统计指定字段所有符合条件数据的平均值。(average) |
| `sum()`    | 统计指定字段所有符合条件数据的总和。           |
| `concat()` | 用指定的字符连接指定多个字段的数据。           |


## 运算符

算数运算符 `+` `-` `*` `/` `%`

比较运算符 `>` `>=` `<` `<=` `=` `!=` `<>`

逻辑运算符 `and` `or` `not` `in` `is nul` `is not nul` `like`
```sql
select * from table where age=23 and name='xxx';

select * from table where age=23 or name='xxx';

select * from table where not (name='小明' or name='小红');

select * from table where id in (1,2,6,8);

select * from table where id not in (1,2,6,8);

select * from table where tel is null;

select * from table where tel is not null;

select * from table where name like '李%';
```

## 联合查询

```sql
-- 联合两条查询数据，如果存在相同的数据，则保留其中一条
(select * from table where id>200)
union
(select * from table where id>200);

-- 联合两条查询数据，如果存在相同的数据，则全部保留
(select * from table where id>200)
union all
(select * from table where id>200);
```

## 子查询
标量子查询
```sql
-- 标量子查询就是 本条查询语句的查询条件 是 另一个查询语句查询出来的单个值
-- 查询id为10的老师所带的所有班级信息
select * from class where teacher_name = (
    select name from teacher where id = 10
);
```
列子查询
```sql
-- 列子查询就是 本条查询语句的查询条件 是 另一个查询语句查询出来的一列结果。
-- 查询id为10和30的老师所带的所有班级
select * from class where teacher_name in (
    select name from teacher where id = 10 or id=30
);
```
行子查询
```sql
-- 本条查询语句中的查询条件 是 另一个查询语句所查出来的一行记录
select * from class where (teacher_name,teacher_num)=(
    select name,num from teacher where id = 10
)
```
表子查询
```sql
-- 本条查询语句所查询的表 是 另一个查询语句查询出来的一个虚拟表结果集。
-- 蠕虫复制
insert into table values(select * from teacher where 1);
```

exists查询
```sql
-- 查询出table1和table2表name字段同时存在相同值的数据
select * from table1 where exists (select * from table2 where table1.name == table2.name);
```

## 连接查询

### 内连接
```sql
-- 在两张表中，如果任意一张表的数据根据条件连不上另外一张表中的数据，则这条记录直接被忽略不展示出来。
select * from table1 inner join table2 on table1.name = table2.name;
-- 内连接的简写方式可以省略inner关键字
select * from table1 join table2 on table1.name = table2.name;

-- 在内连接中，where关键字可以代替on关键字
select * from table1 join table2 where table1.name = table2.name;

-- using演示案例  两个表存在相同的name字段且值相同才连接
select * from table1 join table2 on using(name);
```

### 交叉连接
```sql
-- 所谓的交叉连接，指的是将左表的每条数据都与右表的每条数据连接一次。
-- 如果内连接不指定条件，就是交叉连接。
select * from table1 inner join table2;
```

### 外连接
左外连接
```sql
select * from table left outer join table2 on table.name = table2.name;
-- 简写
select * from table left join table2 on table.name = table2.name;
```
右外连接
```sql
select * from table right outer join table2 on table.name = table2.name;
-- 简写
select * from table right join table2 on table.name = table2.name;
```
全外连接
```sql
-- 左外连接 和 右外连接 联合起来
(select * from table right join table2 on table.name = table2.name)
union
(select * from table right join table2 on table.name = table2.name);
```
自然连接
> 使用要求：两张表有且仅有一个相同的字段，否则数据会出错，所以，实际项目中并没有什么卵用

```sql
-- 自然内连接 等同于 内连接使用using条件
select * from table join table2 using(name);
-- 等同于
select * from table natural join table2;

-- 自然左外连接
select * from table natural left join table2;
-- 自然右外连接
select * from table natural right join table2;
```
