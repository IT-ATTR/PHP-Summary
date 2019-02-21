## mysql扩展
#### 什么是MYSQL扩展
* 概念：PHP利用MYSQL提供的语言操作接口，封装出来的一系列操作MYSQL数据库的函数。

#### 准备工作
* 第一步，打开php.ini文件，配置一个名为extension_dir的配置项，

```
extension_dir='F:/usr/php5.3.5/ext'(存放扩展的目录)
```

* 第二步，确认php_mysql.dll在扩展目录中是否存在，如果存在，则接着在php.ini中开启该扩展配置项

```
extension = php_mysql.dll
```

* 第三步，重启apache，测试MYSQL扩展是否开启成功

* 第四步，构建测试程序phpinfo();如果musql的选项中enabled,则证明开启扩展成功

#### 链接数据库
```php
#我们分别需要通过mysql_connect、mysql_set_charset、mysql_select_db函数来实现。

#第一步连接数据库
$link = mysql_connect("localhost","root","123456");

#第二步设置字符集
mysql_set_charset('utf8',$link);

#第三步选择数据库
mysql_select_db('stu',$link);

#新增数据
$sql = "insert into class name,age,class_name values("kalven",24,'嘉利智联')";
mysql_query($sql,$link);

#删除和修改的原理同新增数据
$sql = "delete from class where id = 1";
mysql_query($sql,$link);

#查询操作稍微不同
$sql = "select * from class where 1";
$result = mysql_query($sql,$link);

#解析查询结果集
mysql_fetch_assoc($result);
```
## mysql_fetch_assoc()的特点
* 1）每次解析都将获得一条数据；
* 2）每条数据都是以数组的形式存在，每个数组元素的下标都是数据的字段名；
* 3）当执行后获得了最后一条数据，再次执行，都将返回false;


### 如何一次取出所有数据呢
```php
whlie($re = mysql_fetch_assoc($result)){
	var_dump($re);
}
```

### mysql_fetch_row和mysql_fetch_array的区别
```php
mysql_fetch_row();
#取出的是索引类型的数组

mysql_fetch_array();
#取出的既有索引类型的数组，又有关联性的数组
```

### mysql_query方式实现设置字符集和选择数据库
```php
$utf8 = "set names utf8";
mysql_query($utf8,$link);

$db = "use stu";
mysql_query($db,$link);
```

### mysql的一些操作函数
* mysql_field_name函数  获得查询的结果集中指定索引位置上的字段名
* mysql_num_fields函数  获得查询的结果集中字段的个数（获得总列数）
* mysql_num_rows函数  获得查询结果集中记录的总行数
* mysql_errno函数  获得错误的错误码值
* mysql_error函数  获得错误的错误码值对应的错误信息
* mysql_insert_id函数  获得最近一次新增数据的主键id值


