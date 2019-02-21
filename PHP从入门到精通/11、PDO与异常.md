## PDO与异常
**为什么使用PDO**
* 在WEB开发中，能够使用的数据库不仅仅只有MYSQL，还可能使用其他的数据库，比如：ORACLE、FIREBIRD、MSSQL等

#### 什么是PDO
* PDO：PHP Data Object  PHP数据对象。
* 在新版本的PHP中，PHP封装了一套PDO扩展库，专门用来操作不同类型的数据库

#### 配置和使用PDO
* 在php.ini中开启php的pdo扩展.开启方法如请参考gd扩展
`$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=db_name",'root','password')`

#### 增删改（exec）
* 增删改操作都是通过调用exec方法实现的。
```php
$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=stu",'root','123456');
$sql = "update class set name='jiangliang' where id = 1";
$pdo->exec( $sql );
```

#### 查操作
```php
$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=stu",'root','123456');
$sql = "select * from class where 1";
$stmt = $pdo->query( $sql );
while($result = $stmt ->fetch(PDO::FETCH_ASSOC)){
	var_dump( $result );
}

//$stmt ->fetchAll();一次查询所有
```
* PDO::FETCH_ASSOC 查询的关联数组
* PDO::FETCH_NUM   查询的下标数组
* PDO::FETCH_BOTH  查询的上面两个数组都有

* $PDOStatement->rowCount  作用： 表示获得查询出来的数据的总行数。
* $PDOStatement->columnCount  作用：表示获得查询出来的数据的总列数（字段总个数）。

## 事务
#### mysql中的事务
* 开启事务 start  transaction;
* 事务逻辑
* 事务逻辑处理没错 commit
* 事务回滚 rollback

#### PDO实现事务
```php
$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=stu",'root','123456');

//开启事务
$pdo->beginTransaction();

//构建标识符
$flag = true;

//事务逻辑
$sql = 'update member set money = money-100 where name = "shuting"';
if (!$pdo->exec($sql)) {
	$flag = false;
}

$sql = 'update member set money = money+100 where name = "jiangliang"';
if (!$pdo->exec($sql)) {
	$flag = false;
}

if ($flag==true) {
	//进行事务操作
	$pdo->commit();
}else{
	//进行回滚操作
	$pdo->rollback();
}
```
## 预处理技术
#### mysql中的预处理技术
```sql
prepare sql1 from "select * from cz_user"

//执行预处理语句
execute sql1;

//删除预处理语句
drop prepare 预处理语句名

//占位符的使用
prepare sql2 from "insert into member values (?,?)"

//设置参数
set @var1 = 'kalven';
set @var2 = 1000;

//执行语句
excute sql2 using @var1,@var2
```

#### PDO中实现预处理技术
```php
//链接数据库
$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=stu",'root',"123456");
//构建语句
$sql = "insert into member values(?,?)";
//进行预处理
$stmt = $pdo->prepare($sql);
//构建绑定数据
$name = "jiangliang";
$money = 1000;
//进行数据绑定
$stmt->bindParam(1,$name);
$stmt->bindParam(2,$money);
//执行预处理语句
$re= $stmt->execte();
//打印结果
var_dump( $re );
```
#### ：字段名形式的绑定
```php
//链接数据库
$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=stu",'root',"123456");
//构建语句
$sql = "insert into member values (:name :money)";
//进行预处理
$stmt = $pdo->prepare($sql);
//构建绑定数据
$name = "jiangliang";
$money = 1000;
//进行数据绑定
$stmt->bindParam(':name',$name);
$stmt->bindParam(':money',$money);
//执行预处理语句
$re= $stmt->execte();
//打印结果
var_dump( $re );
```

#### 使用数组形式的绑定
```php
//链接数据库
$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=stu",'root',"123456");
//构建语句
$sql = "insert into member values (:name :money)";
//进行预处理
$stmt = $pdo->prepare($sql);
//构建绑定数据
$data = array(":name"=>"张无忌",":money"=>1000);
//执行预处理语句
$re= $stmt->execte( $data );
//打印结果
var_dump( $re );
```

## PDO中的异常处理
#### PHP中的一个内置异常类Exception
**演示案例**
```php
$price  = $_GET['price'];
//放置监听代码
try{
	if ($price<0) {
		//如果成立，则实例化异常类的对象
		$re = new Exception("价格不能小于零");
		//将错误对象抛出
		throw($re);
	}
}catch(Exception $aa){
	//接收错误异常对象，获取错误信息
	echo $aa->getMassage();
}
```

#### 在PDO中实现异常类的使用
```php
//链接数据库
$pdo = new PDO("mysql:host=localhost;port=3306;charset=utf8;dbname=stu",'root',"123456");
//设置错误处理模式为异常模式
$pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
//使用结构处理异常
try{
	$sql = "insert into cz_userrrr(name,pwd) values('曹操'，,1000)";
	$pdo->exec( $sql );
}catch(Exception $error){
	echo "错误信息".$error->getMessage()."<br/>";
	echo "错误码值".$error->getCode()."<br/>";
	echo "错误文件".$error->getFile()."<br/>";
	echo "错误行号".$error->getLine()."<br/>";
}
```

