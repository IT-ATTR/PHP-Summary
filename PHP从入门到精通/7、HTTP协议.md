## HTTP协议
#### 什么是HTTP协议
* 概念：浏览器请求服务器时，需要规定请求数据的格式；服务器响应浏览器时，也需要规定响应数据的格式；这些对数据格式的规定就是HTTP协议。
HTTP：Hyper Text Transfer Protocol  超文本传输协议。
>我们的web项目，都是B/S架构，所以，都是浏览器和服务器之间进行交互的一个过程。那么，HTTP协议，就是浏览器和服务器之间沟通的一个协议。

#### HTTP协议的分类
* HTTP协议分为：1）HTTP请求；2）HTTP响应；

#### HTTP请求
* 组成部分总共包含四个： 1）请求行；2）请求头；3）空白行；4）请求数据
**请求头**
* host：当前url中所要请求的服务器的主机名（域名）
* accept-encoding：是浏览器发给服务器,声明浏览器支持的压缩编码类型  比如gzip
* accept_charset：表示，浏览器支持的字符集
* referer：表示，此次请求来自哪个网址
* accept-language：可以接收的语言类型，cn，en等
* cookie：如果之前当前请求的服务器在浏览器端设置了数据（cookie），那么当前浏览器再次请求该服务器的时候，就会把对应的数据带过去
* user-agent：用户代理，当前发起请求的浏览器的内核信息
* accept：表示浏览器可以接收的数据类型，text/html，image/img
* Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
* content-length（post）：只有post提交的时候才会有的请求头，显示的是当前要提交的数据的长度（字节）
* if-modified-since（get）：表示，在客户端向服务器请求某个资源文件时，询问此资源文件是否被修改过
* content-type（post）：用于定义网络文件的类型和网页的编码，决定浏览器将以什么形式、什么编码读取这个文件

**请求数据只有当请求方式为POST方式时才存在**

**响应头**
* server：服务器主机信息
* date：响应时间
* last-modified：文件最后修改时间（对应请求中：if-modified-since）
* content-length：响应主体的长度（字节）
* content-type：响应内容的数据类型：text/html，image/png等
* location：重定向，浏览器遇到这个选项，就立马跳转（不会解析后面的内容）
* refresh：重定向（刷新），浏览器遇到这个选项就会准备跳转，刷新一般有时间限制，时间到了才跳转，浏览器会继续向下解析
* content-encodeing：文件编码格式
* cache-control：缓存控制，no-cached不要缓存

**响应的状态码**
* 1xx：表示请求尚未完成；
* 2xx：表示请求和响应都没有问题；
* 3xx：表示重定向；
* 4xx：表示请求出现问题，响应失败；
* 5xx：表示服务器出现问题，响应失败；

* 200：表示请求和响应都OK
* 301和302：表示永久重定向和临时重定向；
* 404：表示请求时找不到请求的文件，导致响应失败；
* 500和502：表示服务器软件出现故障；

## HTTP协议的特点
* 1) 不仅支持B/S模式，还支持C/S模式（talnet）。
* 2) 灵活，支持任意类型的数据。
* 3) 无连接特性，指的是每次完整的请求之后，本次连接要断开。
* 4) 无状态特性，HTTP协议对会话过程中产生的数据不具有记忆能力。

## PHP模拟HTTP请求
* 首先在php.ini要开启curd扩展
* Curl其实就是利用一些协议提供的接口，封装出来的一些的操作函数。
* curl_init();
* curl_setopt($cli, CURLOPT_URL , 'https:\/\/www.baidu.com' );
* curl_exec($cli);
* curl_close($cli);



## 文件编程
#### 对目录的操作
* mkdir函数      创建一个目录（make directory）如果要递归创建目录(mkdir("./php/dir",0777,true))
* rmdir函数      删除一个目录（remove directory）只能删除一个空的目录
* rename函数     给目录改名或转移目录

#### 查询操作
* opendir函数      打开一个目录
* readdir函数      读取目录中的内容
* closedir函数      关闭一个打开的目录

>readdir函数的特性：1）	每次执行只会读取一个文件；2）	当读取到最后一个文件，再次执行，只会返回false

### 递归遍历目录
```php
function recursiveDir($path,$level=0){
	$file = opendir($path);

	while ($sonfile=readdir($file)) {
		if ($sonfile=='.' || $sonfile=='..') {
			continue;
		}

		#拼接文件的全路径
		$sonpath = $path."/".$sonfile;
		echo str_repeat("---",$level);
		if (is_dir($sonpath)) {
			#是一个文件夹
			echo "<span style='color:red'>".$sonfile."</span><br/>";
			recursiveDir($sonpath,$level+1);
		}else{
			#是一个文件
			echo $sonfile."<br/>";
		}
	}
}

recursiveDir("./demo");
```

#### 查询辅助操作函数
* realpath函数      将给定的路径转换为绝对路径地址
* basename函数      返回当前给定路径的基础文件（或文件夹）名部分
* dirname函数      返回当前给定路径的目录部分
* is_dir函数      判断一个给定文件是否是一个目录

#### PHP4相关的文件操作
* fopen函数    打开一个文件
* fread函数    读取文件中的内容
* fwrite函数    向文件中写入内容
* fclose函数    关闭打开的文件

#### PHP5相关文件操作函数
* file_put_contents函数      向文件中写入内容
* file_get_contents函数      获得文件中的内容
* 判断一个文件是否存在：file_exists函数

#### 实现文件下载
```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>下载文件</title>
</head>
<body>
	<p>
		<a href="javascript:;" onclick="xiazai('txt')">下载TXT</a>
	</p>
	<p>
		<a href="javascript:;" onclick="xiazai('zip')">下载ZIP</a>
	</p>
</body>
<script>
	function xiazai(obj){
		if (confirm("确认下载"+obj+"文件吗？")) {
			window.location.assign("./demo.php?type="+obj);
			//window.location.href("./demo.php?type="+obj);
		}
	}
</script>
</html>
```

```php
if ($_GET['type']=='txt') {
	# TXT文件
	$path = "./a.txt";
	$filename="武动乾坤.txt";
}else{
	# ZIP文件
	$path = "./b.zip";
	$filename="武动乾坤.zip";
}

//告诉服务器，返回流媒体数据格式的数据
header("Content-type:application/octet-stream");
//告诉返回来的文件当成附件
header("Content-disposition:attachment;filename={$filname}");

//将文件输出给浏览器
echo file_get_contents($relityPath);
```