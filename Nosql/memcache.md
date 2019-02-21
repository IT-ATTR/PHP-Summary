## 什么是memcache?

**Memcache是一个高性能的分布式的内存对象缓存系统，通过在内存里维护一个统一的巨大的数据存储表，它能够用来存储各种格式的数据，包括图像、视频、文件以及数据库检索的结果等。简单的说就是将数据放到内存中，然后从内存中读取，从而大大提高读取速度。**

### 格式：在Linux中把Memcache叫做Memcached,存储格式:key=>value（键值对的存储方式）

### 本身特点
* 1)在 Memcache中可以保存的key的数量是没有限制的，只要内存足够 。

* 2)Memcache单进程在32位系统中最大使用内存为2G，若在64位系统则没有限制,这是由于32位系统限制单进程最多可使用2G内存,要使用更多内存，可以分多个端口开启多个Memcached进程

* 3)最大key键长为250字符(key名字组成可以很自由，键盘可见字符都可以使用)

* 4)单个key最大数据是1MB

* 5)memcache可以支持 C/C++、Perl、PHP、Python、Ruby、Java、C#、Lua、MySQL和Protocol等语言客户端

> 小型、轻量化、速度快

### Memcache的安装

**安装的命令： yum -y install memcached telnet telnet-server**

### 启动Memcache的服务器

* 需要启动memcached和telnet的服务器,才能正常使用Memcached

**Memcached服务器指令:service memcached [start|status|stop|restart]**

**Telnet服务器指令:service xinetd [start|status|stop|restart]**

### 使用telnet连接Memcache

**命令格式: telnet [memcache的服务器地址] [端口]**

### Memcache的add,get,set,delete命令

**add命令**

* 命令作用：创建一个存在内存中的key=>value的键值对

* 命令格式: add [key的名称][标识符][过期的时间][字节的大小]

* 标识符：标识符表示内存中的节点,一般设置为0,对于php开发没有太大的意义

* 过期时间：在memcached当中如果设置过期时间为0，表示永久保存，不会过期，如果设置30表示30秒后过期，过期时间以秒为单位。
字节的大小：一般在memcached的命令行（黑窗口）当中字节大小是需要我们自己设定，比较麻烦，用byte来作为单位,对于php开发没有太大的意义

**设置key=name,value=eden,如下所示：**

```
telnet localhost 11211

add name 0 0 4
eden
```

**get命令**

* 命令作用：获取一个memcache的key中value

* 命令格式: get [key的名称]

```
get name
```

**set命令**

* 命令作用:修改或者添加一个键值对,键存在则是修改,不修改则添加

* 命令格式:set [key的名称][标识符][过期的时间][字节的大小]

**delete命令**

* 命令作用:主动删除一个键值对

* 命令格式:delete [key名称]

**过期时间**

* 由于开发中使用set比较多,所以我们可以使用set命令操作memcache的过期时间

* 设置一个键值对在15秒后过期

```
add name 0 15 4

eden
```

### xshell操作memcache的注意事项

* 回退（退格删除）快捷键：

> ctrl + backspace

* 退出memcache命令行:

> ①按下ctrl + ]

> ②在telent>输入quit

### 清空memcache中所有数据

**清空memcached中的内存数据，有两种方法:**

* 第1种方法：重启memcached,使用service memcached restart

* 使用flush_all命令来清空

### 在PHP中安装Memcache的扩展

* 在putty或者xshell当中键入以下命令，进行php扩展安装，命令如下所示:

`yum install -y --enablerepo=remi --enablerepo=remi-php56 libmemcached php-pecl-memcache php-pecl-memcached`

* 重启apache服务器，重启的命令:service httpd restart

* 查看phpinfo.php文件是否扩展已经安装

### Memcached类的常用方法说明

* addServer(host,port):host就是linux服务器的地址，port一般就是11211（memcached的端口），用于连接memcached服务器

* addServers(servers):用于连接分布式memcached服务器

* set(key,value,expire) : 用于修改或者添加内存的memcached数据，该方法有3个参数
key键名，value是键值，exipre是过期时间，expire默认为0表示永远不过期，如果设置为秒，最大只能设置为30天的秒数(30 * 86400秒)

* get(key):获取对于键值对

* delete(key):删除memcached当中键值对

```
$memcached = new Memcached();

$link = $memcached->addServer("localhost",11211);

$memcached->add("name","eden",15);

$memcached->get("name");

$memcached->delete("name");
```

### 使用memcache实现session入库共享

* session在默认的情况下以文件的方式放在Linux当中,所以session.save_handler为files如果网站的访问量很多,在/var/lib/php/session目录下就会变多,硬盘的负载就会过高,有可能会造成硬盘IO崩溃或者损坏.

**在PHP中修改session的存储到memcache**

```
ini_set("session.save_handler","memcache");

ini_set("session.save_path","tcp://localhost:11211");

session_start();

$_SESSION['username']='jiangliang';

echo "session_id".session_id();
```

* 如果是游戏开发中，想要强制让所有用户全部下线，直接使用flush_all命令

### php操作Memcache分布式服务器

```
$memcached = new Memcached();

$servers = array(
	array('192.168.141.196',11211,50),
	array('192.168.141.198',11211,50),
	);

$memcached->addServers($servers);

$memcached->add("name","eden");

echo $memcached->get("name");
```





