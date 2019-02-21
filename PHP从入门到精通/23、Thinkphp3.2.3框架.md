## 什么是框架？
* 所谓的框架,Framework,它就是某个web应用程序的半成品（不要重复造轮子），就是一组组件(分页类、验证码类、文件上传类、DB类、Image类等。。。)，利用这些组件完成自己的web应用系统。

* 从快到慢排序：二次开发(需要修改源码)--->框架开发---->源码开发

## 框架开发的优势
**框架能节省开发时间**
* 每个项目中常用的类库都已经封装好，如分页类、图像类,文件上传类等，直接调用即可,非常方便。（减少重复造轮子）
**利于团队的合作开发**
* 因为框架都是mvc设计模式,模块划分清晰，更有利于项目的分工合作，从而提高开发效率。

## 常见的php开发框架
**ThinkPHP框架（TP框架）**
* 主要开发中小型项目,ThinkPHP框架是我们国人开发采用mvc模式设计的一款比较优秀的框架。在我们国内使用量较多，且开发文档也多，方便学习。

**CodeIgniter 框架(CI框架)**
* 主要开发中小型项目

**YII(易框架)**
* 主要开发大型的web应用程序

**Laravel框架**
* 此框架使用量世界排名第一,有最”优雅”的框架称号

**Zend官方框架**
* php官方提供的框架，非常笨重，主要开发大型的web应用程序

**Symfony国外框架**

**框架只有最合适的，没有最好的，需结合自己的系统业务去选择最合适的。国内使用最多的框架是TP、laravel、CI。YII框架外企使用较多**

### [TP3.2.3框架下载](http://www.thinkphp.cn/down.html)
#### 框架的核心目录说明
```php
---Thinkphp           //框架系统目录
------Common		  //核心公共函数目录
------Conf		      //核心配置目录
------Lang		      //核心语言包目录
------Library		  //框架类库目录
---------Think		  //框架Think类库目录
---------Behavior	  //行为类库目录
---------Org	      //Org类库目录
---------Vendor	      //第三方类库目录
---------...          //其他类库目录
------Mode            //框架应用模式目录
------Tpl             //系统模板目录
------LICENSE.txt     //框架授权协议文件
------logo.png        //框架logo文件
------README.txt      //框架README文件
------index.php       //框架入口文件
```
* Common目录:其目录中有个functions.php文件,定义了框架中所使用到的函数。
* conf目录：框架的核心配置文件目录，其里面有个convention.php文件，所有的框架核心配置在此文件中都可以找到。
* Library/Think目录：常用的类库都在Think目录下面，如：文件上传类、分页类、验证码类等。

### 默认安全页的生成

`define('DIR_SECURE_FILENAME', '')`

### URL的访问的四种模式
**1、普通模式**

`www.jiangliang738.cn/index.php/?m=Home&c=Test&a=test&name=jiangliang&age=21`

**2、pathinfo模式(最好的模式)**

`www.jiangliang738.cn/index.php/Home/Test/test/name/jiangliang/age/21`

**3、兼容模式**

`www.jiangliang738.cn/index.php/?m=Home/Test/test/name/jiangliang/age/21`

**4、重写模式（Rewrite）隐藏入口文件**
```
<IfModule mod_rewrite.c>
	Options +FollowSymlinks
	RewriteEngine On

	RewriteCond %{REQUEST_FILENAME} !-d
	RewriteCond %{REQUEST_FILENAME} !-f

	RewriteRule ^(.*)$ index.php/$1 [QSA,L]
<IfModule>
```
`www.jiangliang738.cn/Home/Test/test/name/jiangliang/age/21`


### URL大小写问题
* ①模块或控制器或方法除了首字母不区分大小写，其他字母一律小写。
* ②全部都小写

### ThinkPHP中的视图
**1、分配变量**
* $this->assign(‘变量名’，”变量值“);

**OR**

* $this->变量名 = 变量值;

**2、输出模板内容**
* $this->display()

**OR**

* echo $this->fetch()

### 模板中常用循环标签的使用
**foreach和volist标签**
```
<foreach name="分配的变量名" item="自定义">
</foreach>


<volist name='分配的变量名' id='自定义' offset='2' length='10'>
</volist>
```

**include包含标签**
```
<include file='Public/Test' />

兼容写法
<include file='Public:Test' />
```
**file的路径是从当前模块的View目录下开始找起。**

**if判断标签**
```
<if condition="($num eq 1) OR ($num gt 100)">value 1
<elseif condition="$name eq 2">value 2
<else />value 3
</if>
```

**php标签**
* 在模板中可以使用php标签如：<php> echo “hello world”;</php>中写我们自己php代码。还可以使用原生的php方式如：<?php echo “hello world”; ?>形式在模板中书写原生的php代码。
**但是注意：原生<?php  ?>的形式，可以通过配置文件禁用，但是php标签的形式仍然可以使用的。**

`TMPL_DENY_PHP=true`


### 系统变量输出
* {$Think.server.script_name}  //获取$_SERVER['SCRIPT_NAME']
* {$Think.session.name}        //获取$_SESSION['NAME']
* {$Think.get.name}            //获取$_GET['NAME']
* {$Think.cookie.name}         //获取$_COOKIE['NAME']


### 模板常量替换
* __ROOT__ 替换成当前网站的地址，不含域名
* __APP__ 替换成当前应用的URL的地址，不含域名
* __MODULE__ 替换成当前模块的URL的地址，不含域名
* __CONTROLLER__ (__URL__)替换成当前控制器的URL地址，不含域名
* __ACTION__ 替换成当前方法的URL地址，不含域名
* __SELF__ 替换成当前页面的URL
* __PUBLIC__ 替换成当前网站的公共目录

**或者自定义规则**
```
“TMPL_PARSE_STRING” => array(
		'__PUBLIC__' => "/Common",
		'__JS__' => "/PUBLIC/JS/",
		'__UPLOAD__' => "/Uploads",
);
```

### 模板中函数的使用
```
转化为大写：{$name|strtoupper}
转大截5个：{$name|strtoupper|substr=0,5}
或者：{:substr(strtoupper($name),0,5)}
```

### 默认值函数的使用
```
{$name|default="很懒，什么也没有留下"}

{$name？$name:"很懒，什么也没有留下"}
```

### 【重点】控制器中的页面跳转和页面重定向
**跳转**
* 成功跳转：$this->success($msg,$url,$time)   
* 失败跳转：$this->error($msg,$url,$time) 

*	msg:跳转的提示信息
*	url:跳转的地址。 成功需要指定跳转地址，成功默认跳转到原来的操作页面，即$_SERVER["HTTP_REFERER"]。失败一般不需要指定，默认返回之前的请求页面，即history.back(-1)。
*	time:跳转的倒计时时间，成功默认1s,失败默认3s


**重定向**
* $this-> redirect(url,[$params],[$time],[$msg]) 

* 1、需要给用户操作的提示信息，则用跳转。
* 2、不需要给任何提示，直接跳到某个页面，则用重定向。

### 空控制器和空操作
* 当请求一个不存在的控制器或者请求某个控制器不存在的方法，就会调用我们定义的空控制器或者空操作，利用此特性可以做404的友好页面设置。
```php
class EmpthController extends Controller{
	public function _empty(){
		$this->display("Public/404");
	}
}
```

### 判断请求类型
* IS_GET: 是否是get请求，满足值为true,否则为false。
* IS_POST：是否是post请求，满足值为true,否则为false。
* IS_AJAX：是否是Ajax请求，满足值为true,否则为false。


### 单字母方法
**U()方法**
* 主要用于生成一些模块或控制器或方法的完整url路径。(路径从网站根目录”/”开始)

**C()方法**
* C方法的作用：主要是获取配置文件中的值。

**I()方法**
* 主要是获取get或post方式提交过来的参数值

**M()**
* 通过M(“表名”)，是实例化核心父类Model，注：表名不包含表前缀。

**D()**
* 实例化的是自定义模型类，如D(“Category”),实例化的是CategoryModel。

### 模型的增删改查（curd）操作
**插入数据**
* $model->add($arr)

**删除数据**
* $model->delete($key)

**更新数据**
* $model->save($arr)

**查询数据**
* $model->select($key)     //$model->select(“1,3,6”)
* $model->find($key)


### 执行原生的sql语句
* $model->query($sql); 	# 执行原生查询(select)的sql语句  成功返回二维数组。
* $model->execute($sql); # 执行原生增删改(insert、delete、update)的sql语句，成功返回受影响的行数。

### 模型的连贯操作方法
```php
field(“filed1,filed2...”) //查询指定的字段field1和field2
where(“name=’xiaoming’ and age=23”) // 条件查询，查询name字段为xiaoming且age字段为23的记录。
order(“field desc”) //把查询的到结果集进行字段field降序（desc）或升序(asc)。
group(“field”) //把查询的到结果集进行字段field分组。
limit(offset,length) //获取结果集指定条数的数据， offset为起始位置，length为获取记录的条数。
join() //联表查询
```
**查询语句的最末端一定要是select或者是find方法。原生sql语句执行顺序： join==>where ==> group ==> having==>order==>limit**

### join联表查询
```php
public function Join(){
	$model = D("test");
	$data = $model
	->field("t1.*,t2.id,t2.name")
	->join("t1 LEFT join table_2 t2 on t1.id = t2.pid")
	->select();

	dump($data);
}
```

### AR模式操作数据库（了解即可）
**其实AR模式就三个核心**
* 表映对应着模型类
* 表的某条记录对应着模型对象
* 表字段对应着对象的属性
```php
public function AR(){
	$Model = D("test");
	$Model->name = "jiangliang";
	$Model->age  = 24;
	$Model->add_time = time();

	dump( $Model->add() );
}
```

### 聚合函数
|方法|说明|
|:----:|:----:|
|Count|统计数量|
|Max|获取最大值|
|Min|获取最小值|
|Avg|获取平均值|
|Sum|获取总分|

### ThinkPHP中的会话技术
* 由于http无状态性。当多个客户端同时请求服务端的时候，服务端无法记录是哪个客户端请求的，所以会话技术主要就是解决识别用户并保持用户信息。

**session操作(CURD)**

|操作|功能|
|:---:|:---|
|session(k，v)|设置session信息|
|session(k)|获取session信息|
|session(k,null)|清除session信息|
|session(null)|删除当前会话所有的session|
|session(“?k”)|判断session信息是否有设置|

**cookie操作(CURD)**

|操作|功能|
|:---:|:---|
|cookie(k,v)|设置一个cookie|
|cookie(k,v,time)|设置一个cookie，并设置有效期为time秒|
|cookie(k,null)	|删除一个cookie|
|cookie(null)|清空在配置文件中通过COOKIE_PREFIX设定前缀所有的cookie|
|cookie(null,’think_’)|清空自定义前缀为think_的所有cookie|

### TP中的常用调试技巧
* 1、dump()变量的调试
* 2、开启页面trace调试

`SHOW_PAGE_TRACE => true`

* 3、【重点】模型的调试

`$model->getLastSql()`

`M()->getLastSql()`

### TP中的文件载入
* 在任意的模块，如公共模块Common或自定义模块Admin中，只要在其模块内的Common文件夹中定义一个function.php（function后不要加s）的文件,此函数文件会被框架自动加载，注意：文件名必须是function.php。

* 如果在任意的模块的Common文件夹中建立一个文件名不为function.php的函数文件，此类文件不会自动加载，我们需要通过以下配置进行加载。
LOAD_EXT_FILE => ‘a,b’   # 如载入函数a.php和b.php ,多个文件用逗号隔开。

`LOAD_EXT_FILE => "fun`

* 按需加载。上面几种定义方法，都会被框架自动加载，如果我们未使用其也会被加载到内存中，这样造成不必要的系统资源开销，我们可以需要的时候按需加载，使用load方法实现。load(“@/c”);


### 【重点】模型的自动验证
**在控制器中通过模型调用create让自动验证生效**
```php
class valiModel extends Model(){
	protected $_validate = array(
		//每一天数组是一条验证规则
		//array(验证字段，验证规则，错误提示，[验证条件,附加规则，验证时间)
		//验证字段，表字段
		//验证规则：配合附加规则来写，默认规则是Regex
		//验证条件：0—存在字段就验证(默认)，1-必须验证 2-值不为空的时验证
		//附加规则：默认为Regex的正则
		//验证时间：1-新增数据时候验证 2-编辑数据时候验证 3-全部情况下验证(默认)
		array("name",'require','名称不能为空',0,'regex',1),
		array("name",'/^[^0-9].+$/','名称不能以数字开头',0,'regex',1),
		array("name",'','名称不能重复',1,'unique',1),
		array("name",'checkname','用户名错误',1,'callback',1)
	);

	public function checkname(){
		return $pid==''? flase:true;
	}
}
```


### 自动完成
```php
class valiModel extends Model(){
	protected $_auto = array(
		//array(完成字段1，完成规则，【完成条件，附加规则】)
		//完成条件：1--新增数据处理（默认） 2编辑数据处理 3-所有情况都处理
		//如果用户设置了时间则用用户的，否则给生成时间戳
		array("add_time",'setTime',1,1,'callback')
	);
}

public function setTime($add_time){
	if ($add_time=='') {
		return time();
	}else{
		return strtotime($add_time);
	}
}
```










