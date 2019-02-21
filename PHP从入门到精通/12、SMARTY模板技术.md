## SMARTY[模板技术](https://www.smarty.net/)
#### 为什么学习SMARTY模板技术
```
在web项目开发中，我们的开发过程一般分为前端开发和后台开发；

前端开发 ==》 负责编写html页面和效果
后台开发 ==》 负责编写功能程序代码

我们以前编写代码的方式是HTML代码和PHP代码混合编写，这样的方式不利于分工合作，
比如当我需要对现有页面进行改版，前端人员不懂PHP程序，只能写好HTML页面，再交给后台开发人员重新嵌套PHP程序。
```
* 1，能够让前端和后台人员进行无缝对接；（数据层面）
* 2，能够提升团队的开发和维护效率。

#### 什么是SMARTY模板技术
* 模板技术就是一种将HTML代码和PHP代码强制分离的一套模板机制。
* 这样一来，前端设计师所维护的HTML代码绝对不会出现任何的PHP代码，便于维护！
* 市面上有众多的模板技术，SMARTY只是其中的一种。

#### 最早期smarty模板技术实现原理
```php
class samrty{
	private $_arr=array();//用来保存占位符和需要替换成的数据数组，占位符是键，数据是值

	//替换功能
	public function assign($arr_key,$arr_val){
		$this->_arr[$arr_key] = $arr_val;
	}

	//渲染模板功能
	public function display($filepath){
		//读取源文件，看其中有没有占位符
		$content  = file_get_contents($filepath);
		foreach ($this->_arr as $arr_key => $arr_val) {
			//将其中需要替换的内容替换掉
			$content = str_replace($arr_key , $arr_val, $content )
		}

		//输出替换后的内容
		echo $content;
	}

}

```

**总结实现原理：读取，替换和输出。**


### SMARTY模板引擎技术的特点（优劣特点）
* 1，smarty是一个基于PHP开发的PHP模板引擎，由于采用PHP编写，所以语法结构与PHP基本类似，语句比较自由；
* 2，相对其他的模板引擎，具有更快的响应速度（速度快）；
* 3，Smarty插件非常灵活，可以任意的扩展；
* 4，也有不适合运用Smarty的地方，比如实时更新的项目（股票的走势），因Smarty把数据都缓存起来了，没法实时更新！

### SMARTY模板编译的原理
* 当我们首次访问网站的某个页面时，SMARTY会自动在项目的smarty核心库目录同级的目录中创建一个名为templates_c的目录，这个目录存放的就是SMARTY的模板编译缓存文件。

* SMARTY有一个机制，如果第一次访问某个模板页面，则会自动创建一个该模板页面对应的编译缓存文件；下次再来访问该页面时，则SMARTY会判断该模板页面是否已经发生改变，如果没有发生改变，则直接去访问编译缓存文件，如果发现模板内容有被改变，则重新编译生一个新的缓存文件，覆盖老的缓存文件。

### SMARTY中属性的相关设置
### 定界符
* 默认的左定界符：{
* 默认的右定界符：}

### 相关目录设置
**在Smarty2.0版本中，可以修改以下的四个属性：**
* template_dir：模板目录，默认为templates
* compile_dir：编译目录，默认的是templates_c
* config_dir：配置目录，默认为configs
* cache_dir：缓存目录，默认为cache

**在Smarty3.0以后的版本，上面的四个属性都被定义成了private私有属性，我们可以调用Smarty对象的四个接口方法进行更改：**
* setTemplateDir()   修改模板目录
* setCompileDir()    修改编译目录
* setConfigDir()    修改配置目录
* setCacheDir()    修改缓存目录

### 修改案例
```php
//实例化smarty对象
$smarty = new Smarty;
//修改模板文件的目录
$smarty->serTemplateDir('./views');
```

### smarty常量设置
* 通常情况下，我们在项目程序文件中，会定义一个名为SMARTY_DIR的常量，定义这个常量的原因是有时候需要向下兼容老版本的SMARTY。
`define('SMARTY_DIR',dirname(__FILE__).'/smarty/')`

### SMARTY系统变量
* {$smarty.get.变量名称}    直接获取GET参数数据
* {$smarty.post.变量名称}      直接获取POST参数数据
* {$smarty.cookies.变量名称}     直接获取COOKIE参数数据
* {$smarty.session.变量名称}     直接获取SESSION参数数据
* {$smarty.const.常量名称}      直接获取常量参数数据
* {$smarty.now}      直接获取当前时间的时间戳

### foreach
**定义语法**
```
{foreach  from=$目标数组模板变量 [key=’保存元素下标的模板变量名’ ]  item=’保存元素值的模板变量名’  [name=’当前foreach的别名’]}
	foreach遍历结构体
{/foreach}
```

### foreach内置变量
* {$smarty.foreach.foreach循环名.index}     表示获得当前的索引值
* {$smarty.foreach.foreach循环名.iteration}    表示获得当前遍历的次数（当前遍历到了第几次）

### if…elseif…else
```
{if $smarty.get.score>=90}
优秀
{elseif $smarty.get.score>=70}
良好
{else}
不及格
{/if}
```

### literal
* 作用：被该内置函数包裹的部分不会被当成smarty内容来解析。
```
{literal}
p{
	margin:0 auto;
}
{/literal}
```

### ldelim和rdelim
*作用：表示直接在模板页面输出左右定界符的符号。


## 变量调节器
**变量调节器基本语法：{变量名|调节器名1:参数1:参数2….|调节器名2:参数1:参数2….}** 
* cat
* 功能： 拼接指定的字符。
```php
$var1 = 'kalven';
$var2 = 'love';
$var3 = 'huangjian'

{$var1|cat:$var2:$var3}
//结果：kalvenlovehuangjian
```

**date_format**
* 功能：表示将指定的时间戳格式化为指定的日期时间格式数据。
`{$smarty.now|date_format:'%Y-%m-%d %H-%M:%S'}`

**default**
* 功能：表示如果某个模板变量不存在则给定默认值。
`{$var|default:"爱情也许是神话"}`

**lower和upper**
* 功能：lower表示将字符串转换为小写字母；upper表示将字符串转换为大写字母。
`{$var='ABC'|lower}`

**escape**
* 功能：表示将变量中的html字符标签当成普通字符串输出。

**nl2br**
* 功能：表示将文件的回车换行转换为html能解析的<\br\/>换行标签。

**strip_tags**
* 功能： 表示将html标签字符直接去除。


