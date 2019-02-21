### mongodb

* MongoDB 是一个介于关系数据库和非关系数据库之间的产品，是非关系数据库当中功能最丰富，最像关系数据库的，但是mongdb做不到关系型数据的连表，外键等操作，它的存储数据方式有点类似于Json格式，Mogodb叫做这种格式叫为Bson（big json），Mongodb是一个面向集合的，模式自由的文档型数据库。

* MongoDB能很好地支持PHP

* MongoDB安全性是所有NOSql最好的

* MongoDB安装的文件比较大,占据了一定的硬盘空间

### 应用范围和限制

* 缺点:不支持连表查询，不支持sql语句，不支持事务存储过程等，所以不适合存储数据间关系比较复杂的数据，一般主要是当做一个数据仓库来使用。

* 适用于：日志系统，股票数据等。

* 不使用于：电子商务系统等需要连多表查询的功能

### 文档
**文档是mongoDB中数据的基本单元，类似关系数据库的行,多个键值对有序地放置在一起便是文档。**

`{ “username”:”Tom”, “age”:10 ,email:’xiaobai@sohu.com’,’sex’:男}`


### 集合(表)

* 集合就是一组文档，多个文档组成一个集合，集合类似于 mysql里面的表 。

* 模式自由（schema-free）：意思是集合里面没有行和列的概念，

* 注意：MongoDB中的集合不用创建、没有结构，所以可以放不同格式的文档。

### 数据库

* 多个集合可以组成数据库。一个mongoDB实例可以承载多个数据库，他们之间完全独立。 
Mongodb中的数据库和Mysql中的数据库概念类似，只是无需创建。

* 一个数据库中可以有多个集合。

* 一个集合中可以有多个文档。

### 安装mongodb(27017)

`yum -y install mongodb mongodb-server`

`service mongod start`

### Mongodb的数据库相关命令

**1、mongo命令**

* 命令功能:用于登录mongodb的命令行

```
mongo [-u登录名] [-p登录密码] [localhost:27017/验证数据库]

mongo -uroot -p123456 localhost:27017/admin
```

**2.show dbs命令**

* 命令作用:相当mysql的show databases();命令

**3.use命令**

* 命令作用:相当mysql当中use命令,选择数据库,但是mongodb的use命令可以选择一个数据库,也可以创建一个数据库,如果数据库已经存在就是选择数据库

**4.db命令**

* 命令作用:相当于mysql当中select d示当前正在操作的数据库

**5.show tables命令**

* 命令作用:显示当前数据库的集合(表)

**6.db.help()命令**

* 命令作用:显示数据库的帮助文档信息

**7.db.dropDatabase()命令**

* 命令作用:删除当前正在操作的数据库,删除数据库会让集合和文档全部丢失

**8.db.集合名称.help()命令**

* 命令作用:显示当前操作数据库中的集合相关帮助文档信息

### 在mongodb中实现聚合查询(口诀:比较操作符一定在字段之内,$set修改器一定在字段以外,$or和$and必须使用[])

**1.insert命令**

* 命令格式:db.集合名称.insert( {bson数据} )

* 集合名称:在Mongodb中集合相当于表,这个表是无需创建,如果表不存在那么就是自动创建,如果存在就是选择.

`db.class.insert({name:'eden',age:24})`;

**2.find()命令**

* 命令格式: db.集合名称.find({条件})[.limit().skip().count(true)]

* 查询_id小于等于7的文档,并且跳过前面3条记录,统计当前可以查询出多少个文档?

`db.class.find( {_id:{'$lte':7}} ).skip(3).limit(4).count(true)`

**如果在mongodb中没有使用count(true),那么count无法把skip和limit看成一个条件**

**3. 使用$or操作符**

* 符号的作用:相当于mysql当中or操作符

* 查询_id小于等于5或者name为eden的文档

`db.class.find( {'$or':[{_id:{'$lte':7}},{name:'eden'}] )`

**4.使用$and操作符**

* 符号的作用:相当于mysql当中and操作符

* 例子:查询name为eden并且lesson为laravel的文档

`db.class.find( {'$and':[{name:"eden"},{lesson:'laravel'}] )`

**5.把文档进行排序操作,使用sort()命令**

* 语法规则:db.集合名称.find().sort( {字段:-1/1} );

* 1:代表升序排列,相当于asc的操作,默认为asc

* -1:代表降序排列,相当于desc的操作

* 例子:查找_id小于10的文档,按照_id字段降序(从大到小)排列

`db.class.find( {'_id':{"$lt":10}} ).sort({_id:-1})`

**6.update命令和$set修改器**

* 命令格式:db.集合名称.update( {条件},{‘$set’:{字段:值}},false,true );

* 第3个参数表示关闭只修改单行记录功能，false表示修改可以发生在多行记录中

* 第4个参数表示启动批量修改功能

* 例子：修改_id<7的数据lesson为laravel

`db.class.update( {"_id":{"$let":7}},{"$set":{"lesson":"laravel"}},false,true )`

**7.remove()命令**

* 语法规则:db.集合名称.remove( {条件} );

**8.$in操作符**

* $in操作相当于mysql中in操作语句,不过in在mongodb中是非常快速,因为$in一定可以使用上索引,语法规则如下

`db.集合名称.find( {字段:{'$in':[....]}} )`

`db.class.find( {'_id':{'$in':[11,22,33,44]}} )`

### mongodb中索引和执行计划

**1.创建索引**

* 语法格式:db.集合名称.ensureIndex( {字段:1},{索引的属性} );

* {字段:1}：表示在某个字段中设置索引，1表示true

* 为class2的name字段添加普通索引

`db.class.ensureIndex( {name:1} )`

* 为class3的name字段添加唯一性索引

`db.class.ensureIndex( {name:1},{unique:true} )`

**2.执行计划explain**

* 执行计划是查看一个find（）是否可以使用上索引

* 语法格式:db.集合名称.find({条件}).explain();

### 与索引相关的其他指令

**1.getIndexes()命令**

* 命令的作用：用于查询一个集合当中的索引有哪些

`db.class.getIndexes()`

**2.dropIndex()命令**

* 命令作用：删除集合中指定的索引，比如说删除class3中，索引名称name_1的索引

`db.class.dropIndex('name_1')`

### mongodb的安全权限验证

**mongodb号称世界上nosql产品中最安全的产品，mongodb拥有权限验证机制和加密功能，如果希望启动mongodb的安全验证，要遵循以下步骤的顺序**

* 第1步：切换到隐藏数据库admin当中

* 第2步：使用addUser命令，addUser命令有两个参数:

> db.addUser('root','密码');

> 密码必须要有引号引住，使用addUser命令创建root用户,密码为123456

* 第3步：使用exit命令退出mongodb

**建议为了包含mongodb.conf不被其他用户修改，所以要停止**

* 第4步：修改/etc/mongodb.conf文件

`vim /etc/mongodn.conf`

> 打开后，找auth选项

`auth=true`

> 保存并退出（:x）,然后重启mongod服务

* 第6步：如果我们继续使用mongo发觉还是可以登录,但是没有操作权限

> mongo -uroot -p123456 localhost:27017/admin

### 修改root密码的方法

**在mongodb中有两个经典版本，一个是2.4，一个是2.7都使用addUser来进行密码修改，如果在admin数据库中，添加了root用户，那么再次添加，就是修改密码，如果root用户不存在则是添加root用户**

### 使用php操作mongodb

**口诀：遇到.换成->,遇到{}或者[]变成array**

**1、安装php的mongodb扩展**

`yum install -y --enablerepo=remi --enablerepo=remi-php56 php-pecl-mongo`

**安装完成，重启apache服务器,查看phpinfo文件**

**2.使用phpl连接Mongodb**

```
header("content-type:text/html;charset=utf8");

$mongo = new MongoClient("mongodb://root:123456@localhost:27017/admin");

$db = $mongo -> SelectDb('eden');

$db-> class -> insert([
		"name" => 'eden',
		"age"  => 24,
		'job'  => 'PHP工程师'
	]);

echo "insert ok!"
```

**3.在mongodb中查询数据**

```
header("content-type:text/html;charset=utf8");

$mongo = new MongoClient("mongodb://root:123456@localhost:27017/admin");

$db = $mongo -> SelectDb('eden');

$cursor = $db->class->find();

$data = iterator_to_array($cursor);

foreach($data as $key => $re){
	echo $key;
}
```

**4.在mongodb中使用操作符**

* 例子1:查询class3中_id大于等于996的文档

```
header("content-type:text/html;charset=utf8");

$mongo = new MongoClient("mongodb://root:123456@localhost:27017/admin");

$db = $mongo -> SelectDb('eden');

$cursor = $db->class->find( array(
		"_id"=>['$gt'=>996]
	) );

$data = iterator_to_array($cursor);

var_dump( $data );
```

### 使用tp操作mongodb的CURD

**Think\Model\MongoModel这个类只关心3个属性:**

* protected $connection : 表示链接mongodb的字符串

* protected $dbName : 表示选择或者创建一个mongodb的数据库

* protected $tableName : 表示选择或者创建一个mongodb中的集合

* 在tp中操作monogodb必须要声明Model,且在控制器中只能使用D方法

```
Class TestModel extends MongoModel{
	protected $connection = "mongo://root:123456@localhost:27017/admin";

	protected $dbName = 'tp';

	protected $tableName = "room"
}
```
