## XML
#### 什么是XML
>全称:extensible markup  language
>中文名:可扩展的标记语言
>标记语言：html,xhtml,html5,xml
**可扩展：标签可以自定义**

**特点**
* 1、传输数据：作为不同开发语言之间传输数据的标准（json,xml）
* 2、保存数据：可以充当小型数据库。

**如何定义XML**
```xml
<?xml version='1.0' encoding='utf-8' ?>
<games>
	<game>
		<name>王者荣耀</name>
		<intro>公平5V5游戏</intro>
	</game>
	<game>
		<name>绝地求生</name>
		<intro>落地成盒,生死各安天命</intro>
	</game>
	<game>
		<name>我的世界</name>
		<intro>这片大陆由你主宰</intro>
	</game>
</games>
```
**xml文档的特点**
* 第一行是xml文档的声明,有两个属性version(版本),encoding(编码)。
* xml文档是一个树形的结构,从树根向下扩展到枝叶,有且仅有一个根标签。
* xml文档有三种元素:节点、节点属性、节点内容。
* 标签严格区分大小写
* 属性值一定要用引号(单引号或双引号)引起来

**在xml文档中,单引号、双引号和大于号可以不用转义,xml会自动识别,但是用实体引用来代替它是一个好习惯**

**CDATA区段**
* 当元素文本内容较多又含有一些特殊字符时，如果有特殊字符再使用实体引用一个个转移比较麻烦，我们可以将这个内容放入CDATA区段中，就不需要一个个转移。
* 语法："<!\[CDATA\[ 内容 \]\]>"
```xml
<?xml version='1.0' encoding='utf-8' ?>
<games>
	<game>
		<name>王者荣耀</name>
		<intro>
			<![CDATA[
				《王者荣耀》是腾讯第一5V5团队公平竞技手游,于10月28日开启不限号测试!5V5王者峡谷(含迷雾模式)、5V5深渊大乱斗、以及3V3、1V1等多样模式一键体验,热血竞技尽享
			]]>
		</intro>
	</game>
	<game>
		<name>绝地求生</name>
		<intro>落地成盒,生死各安天命</intro>
	</game>
	<game>
		<name>我的世界</name>
		<intro>这片大陆由你主宰</intro>
	</game>
</games>
```

**xml的应用场景**
* xml的主要作用就是保存数据和作为不同开发语言之间的传输数据的标准
* 1)保存数据（php对xml使用并不多，像java和android使用xml较多,如迅雷的配置文件，小型数据库
* 2)API接口中返回的数据
```php
$api = "http://api.map.baidu.com/telematics/v3/weather?location=%E5%8C%97%E4%BA%AC&output=json&ak=lllges3Du0M5smzx8GGqktEFIZqVQD1C";
```

**simplexmlElement(主要操作xml文档)**
* 1、得到simplexmlElement的对象
```php
simplexml_load_file(xml文件的路径); //加载外部的xml文件到内存中去
simplexml_load_string(xml字符串); //加载一个xml格式的字符串到内存中

$xml = simplexml_load_file("games.xml","SimpleXMLElement",LIBXML_NOCDATA);
var_dump( $xml );
```

* 2、常用操作方法如下

|方法名|说明|
|:---:|:---|
|simplexml_load_file(xml文件的路径) or simplexml_load_string(xml字符串) |加载xml文件到内存中|
|addChild ( string $name [, string $value ])|添加子节点|
|addAttribute ( string $name [, string $value ]) |添加节点属性|
|asXML ([ string $filename ] ) |保存xml文档（只要对xml文档进行了增删改，最后都要保存。）|
|children() |遍历节点|
|attributes() |遍历节点属性|
|unset() |删除节点|

**案例：如添加一个game节点，且在game节点下面添加name和intro的节点，name节点内容为QQ飞车，intro节点内容为飞车介绍。并且给game节点添加一个id的属性值为funny**
```php
$xml  = simplexml_load_file("game.xml");
$book = $xml -> addChild('game');
$book -> addChild("name","QQ飞车");
$book -> addChild("intro","酣畅淋漓的飞车体验");
$book-> addAttribute("id","funny");

$xml->asXML("games.xml");
```

**把name为王者荣耀的简介改成腾讯捞钱利器**
```php
$xml  = simplexml_load_file("game.xml");
foreach($xml->children() as $game){
	if($game->name == "王者荣耀"){
		$game->intro = "腾讯捞钱利器";
	}
}

$xml->asXML("games.xml");
```

**Xpath路径查询实例**
* 我们也可以通过SimpleXMLElement提供的xpath方法来进行路径查询：、
```
Xpath是一门在xml文档中根据路径查找节点的语言
基本的Xpath语法类似于在一个文件系统中定位文件,如果路径以单斜线 / 开始, 那么该路径就表示到一个元素的绝对路径（从根路径开始找）
如果路径以双斜线 // 开头, 则表示选择文档中所有满足双斜线//之后规则的元素(无论层级关系)，就是相对路径

模糊查询：
title[contains(text(),’php’)]		//查找节点内容包含php的title节点
title[contains(@attrName,’php’)]		//查找属性名为attrName，且值包含的php的title节点的

等值查询：
title[text()=’php’]		//查找节点内容为php的title节点

或查询（满足符号 or 左边或右边的一个条件即可）
title[@attrName1>=10 or @attrName2>=20]
查找属性名为attrName1且值大于10或者属性名为attrName2且值大于20的title节点
```

**找出所有game节点**
```php
$xml = simplexml_load_file("games.xml");
$game = $xml->xpath("/games/game");
$gameAttr = $xml->xpath("name[contains(@attrName,'funny')]");

echo count( $game );
echo count( $gameAttr );
```

**案例：电影查询**
```php
<?php
	header("content-type:text/html;charset=utf8");
	if ($_POST['submit']) {
		$city = trim($_POST['city']);

		$city = empty($city) ? "广州" : $city;
	$url = "http://api.map.baidu.com/telematics/v3/movie?qt=hot_movie&location={$city}&ak=fCWHp1a9QdsHwfPbHZ20LGLzgpKHEGrc";
	
	$xml = file_get_contents( $url );

	$moviesXml = simplexml_load_string($xml);
	
	$movies = $moviesXml->result->movie->item;

	}
 ?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>小工具</title>
</head>
<style type="text/css" media="screen">
	*{
		margin: 0;
		padding: 0;
	    font-family:"Arial","Microsoft YaHei","黑体","宋体",sans-serif;
	}
	.container{
		width: 100%;
		border-bottom: 1px dashed #ccc;
		margin-top: 20px;
		float: left;
		position: relative;
	}
	.info{
		/* border: 1px solid red; */
		float: left;
	}
	.pic{
		width: 200px;
		height: 290px;
		margin: 0 10px;
		float: left;
	}
	h4:not(5){
		float: left;
	}
	.score{
		font-size: 25px;
		color: red;
		position: absolute;
		right: 100px;
		top: 0px;
		border-bottom: 1px dashed #ccc;
	}
</style>
<body>
	<h3>电影查询</h3>
	<form action="" method="post" accept-charset="utf-8">
		<p>
			<input type="text" name="city" placeholder="输入查询城市">
			<input type="submit" name="submit" value="查询电影">
		</p>
	</form>
	<?php if(isset($movies->movie_picture)): ?>
		<?php foreach($movies as $movie):?>
	<div class="container">
		<div class="pic">
			<img src="<?php echo $movie->movie_picture; ?>" alt="" width="100%" height="100%">
		</div>
		<div class="info">
			<h4 class="name">名称：<span><?php echo $movie->movie_name; ?></span></h4><br />
			<h4 class="director">导演：<span><?php echo $movie->movie_director; ?></span></h4><br />
			<h4 class="starring">主演：<span><?php echo $movie->movie_starring; ?></span></h4><br />
			<h4 class="nation">国籍：<span><?php echo $movie->movie_nation; ?></span></h4><br />
			<h4 class="intro">简介：<span><?php echo $movie->movie_message; ?></span></h4><br />
			<h4 class="score">评分：<span><?php echo $movie->movie_score; ?></span></h4><br />
		</div>
	</div>
        <?php endforeach; ?>
	<?php endif; ?>
</body>
</html>
```
