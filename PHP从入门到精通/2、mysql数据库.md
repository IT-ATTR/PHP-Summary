## mysql数据库
#### date函数和time函数
> **时间戳：** 表示UTC时间从1970年1月1日0时0分0秒开始一直到当前时间的秒数差。time函数就是返回一个时间戳。

#### date函数演示案例：将时间戳转换为指定的时间日期格式类型数据
```php
$utcTime = date("Y-m-d H:i:s",time());
var_dump($utcTime);
```

#### mysql的优点
>MySQL是一种开放源代码的关系型数据库管理系统（RDBMS），MySQL数据库系统使用最常用的数据库管理语言--结构化查询语言（SQL）进行数据库管理。
```
1)	执行速度快，MYSQL是市面上执行SQL速度最快的SQL软件之一；
2)	并发处理能力好，理论上可以同时处理几乎不限数量的用户；
3)	存储能力强，可以处理多达50000000以上的记录；
4)	对商业和个人用户均开源并且免费；
```

#### 数据库的分类
* 数据库通常分为层次式数据库、网络式数据库和关系式数据库三种。而不同的数据库是按不同的数据结构来联系和组织的。
在当今的互联网中，最常见的数据库模型主要是两种，即关系型数据库和非关系型数据库。


#### Windows中启动与停止MYSQL服务（在安装的时候要添加环境变量）
* 命令行方式
* 启动MYSQL服务：net start mysql
* 关闭MYSQL服务：net stop mysql
* 退出MYSQL语句语法1：exit
* 退出MYSQL语句语法2：quit
* 退出MYSQL语句语法3：ctrl+c
* 退出MYSQL语句语法4：\q

#### 数据库的操作
* 登录数据库 mysql -uroot [-hlocalhost] [-P3306] -p123456
* 设置字符集 set names utf8
* 显示数据库 show databases
* 创建数据库 create database 数据库名
* 删除数据库 drop database 数据库名
* 删除数据库 drop database if exists 数据库名
* 选择数据库 use 数据库名
* 显示数据表 show tables
* 创建数据表 create table 表名
* 删除数据表 drop table 数据库表
* 删除数据表 drop table if exists 数据库表
* 显示表结构 describe 表名
* 格式化显示 describe 表名\G
* 简写表结构 desc 表名
* 展示表结构 show create table 表名 [or] show create table 表名\G
* 修改表属性 alert table 表名 charset = utf8
* 修改表名称 rename table [库名.]旧表名 to [库名.]新表名;（也可以转移一个表到指定的库中。）
* 添加表字段 alert table 表名 add 心字段名 字段类型 [字段属性列表]
* 删除表字段 alter table 表名 drop 字段名
* 改变字段名 alter table 表名 change 旧字段名 新字段名 新字段类型 [字段属性]
* 改变表属性 alter table 表名 modify 字段名 字段新类型 [字段新属性列表]


#### 表中数据的操作
**新增**
* insert into 表名 (字段1，字段2，字段3) values (值1，值2，值3);

**删除**
* delete from 表名 where id = 表id;

**查询**
* select * from 表名 where id = 表id;

**修改**
* update 表名  set 字段1 = 值1,字段2 = 值2 where id = 表id;

#### MYSQL基础设置
* 查看支持的字符集 show charsets
* 设置字符集 show variables like 'character_set_%'
* 设置客户端字符集 set character_set_client=目标编码
* 设置客户端解析字符集的编码 set character_set_results=目标编码;

#### 连库三步走
* 连接数据库 mysql -uroot -ppassword
* 设置字符集 set names utf8
* 选择数据库 use 数据库名称

#### 数据库字段类型
**在MYSQL中也存在数据类型，分别为：1）整型类型；2）小数类型；3）时间日期型；4）字符串类型；**

#### mysql的语句的高级操作
* replace语句 replace实际上就是替换insert语句中的insert关键字的，实现的功能和insert语句一模一样。
* group by语句 作用：用于分组统计，常与聚合函数一起使用。
* having语句 作用：功能上类似于where语句，负责在结果中再次进行条件过滤。
* order by子句 作用：用来按照指定的字段进行排序的。
* limit子句 用来限制查询出来的记录的条数。
* as子句 用来取别名。
* not表示如果not后面的条件为真，加上not后就为假；如果not后面的条件为假，加上not就为真
* in运算符 in表示在集合中才为true
* union联合查询 union联合查询其实就是通过union关键字将多条查询SQL语句连接起来。
* union all联合查询 union all联合查询与union联合查询大体上功能相同，但是在保留重复记录方面有所区别。

#### 聚合函数
* count函数   统计指定字段在表中的记录总条数，不统计null值。
* max函数  统计指定字段数据的最大值。
* min函数  统计指定字段数据的最小值。
* avg函数  统计指定字段所有符合条件数据的平均值。(average)
* sum函数  统计指定字段所有符合条件数据的总和。
* concat函数  用指定的字符连接指定多个字段的数据。

#### 子查询
**按照查询结果来进行划分：1）标量子查询；2）列子查询；3）行子查询；4）表子查询；**
```
标量子查询
标量子查询中的标量指的是 一个单个的值。
概念：标量子查询就是 本条查询语句的查询条件 是 另一个查询语句查询出来的单个值。

列子查询
概念：本条查询语句的查询条件 是 另一个查询语句查询出来的一列结果。

行子查询
概念：本条查询语句中的查询条件 是 另一个查询语句所查出来的一行记录。

表子查询
概念：本条查询语句所查询的表 是 另一个查询语句查询出来的一个虚拟表结果集。
```

#### 连接查询
* 连接查询分为：1）内连接；2）外连接；3）自然连接；
* 内连接：1）内连接；2）交叉连接；
* 外连接：1）左外连接；2）右外连接；3）全外连接；
* 自然连接：1）自然内连接；2）自然外连接；
```
1）内连接
select * from stu [inner(可省略)] join class on stu.class_name = class.name;
只有满足条件的数据才会展示出来，条件不满足的直接忽略不显示

2）交叉连接（笛卡尔积）
概念：所谓的交叉连接，指的是将左表的每条数据都与右表的每条数据连接一次。
连接方法：如果内连接不指定条件，就是交叉连接。
select * from stu [inner(可省略)] join class

3）左外连接
以左边的表为基准，连接右边的表，如果匹配到则显示，匹配不到，左边表显示，右边表用Null填充
select * from stu left join class on stu.class_name = class.name;

4）右外连接
以右边的表为基准，连接左边的表，如果匹配到则显示，匹配不到，右边表显示，左边表用Null填充
select * from stu right join class on stu.class_name = class.name;

5）全外连接；
将左外连接和右外连接使用union和union all连接起来
union 将不保留重复记录
union all将保留重复记录

6)自然内连接
概念：自然内连接 等同于 内连接使用using条件。
连接方法：使用关键字natural  join
select * from stu natural join class on stu.class_name = class.name;

7)自然外连接
自然外连接包括：a）自然左外连接；b）自然右外连接；
自然左外连接演示案例：
连接方法：使用natural  left  join关键字实现
自然左外连接演示案例：
连接方法：使用natural  left  join关键字实现
```

### 外键
* 使用外键的前提：外键所存在的表必须是Innodb引擎的。
* 设置外键语法：foreign key (外键字段) references 主表 (主表关联字段) [删除时执行语句]  [更新时执行语句]
* 默认情况下被关联的外键数据是无法删除的
* 默认情况下被关联的字段值是无法被修改的


### 数据库的范式
```
1NF(具有原子性，所有的列都不可再分)
2NF(要遵循1NF，每列都必须有唯一标识，且表中某个字段不能对表中其他字段形成依赖关系。解决方法加主键，确定唯一性)
3NF 遵循第二范式，并且不能形成依赖传递。
逆范式 逆范式其实指的就是我们在项目中经常会打破范式的规则来构建表结构。
```

### 视图
* 创建视图的语句语法：create  view  视图名称  as  (查询SQL语句);
```
create view v1 as (select * from stu where id > 3)

查看视图数据
select * from v1 where 1;

更新视图的一条数据
update v1 set name='kalven' where id=2;

可以发现更改了视图数据之后，原表的数据也会被更改
```

> 视图其实是以表子查询的SQL语句的形态存在的；

> 操作视图就相当于操作原表；

### 修改默认结束符(;)
* delimiter 自定义符号

### mysql中的循环结构
```
mysql中的if循环(不能再全局作用域中使用)
if  条件语句  then
	if结构体
[elseif  条件语句  then
	elseif结构体]
else
	else结构体
end if;


while循环
语句语法：
while 条件 do
	循环结构体
end while;

```

### mysql中的变量分类
* 1）系统变量；2）用户变量；3）局部变量；
```
系统变量
分为：1）全局变量；2）会话变量；
查看所有的全局变量操作：show  global  variables;

在入门的时候我们使用过：show variables like '%character_set_%'去查看过字符集的变量
修改全局变量的语句语法：set  @@global.变量名=变量值;

查看所有的会话变量操作：show  session  variables;
修改会话变量的语句语法：set  @@session.变量名=变量值;

用户变量
定义用户变量语句语法：set  @变量名=变量值;

select语句定义用户变量。
定义语法：select  @变量名1:=字段1, @变量名2:=字段2, …, @变量名n:=字段n  from  表名  [where 条件]；

局部变量
定义局部变量的语句语法：declare  变量名  变量数据类型  [default  默认值];
```





