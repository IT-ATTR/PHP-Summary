### [Redis数据库](http://www.redis.cn)

* String（字符串类型）

* list（链表）

* hash（哈希表类型）

* set（无序的集合）

* sorted set(有序集合,缩写为zset)

**Redis为高并发而生，是NoSql中的佼佼者,Redis读的速度是110000次/s,写的速度是81000次/s 。**

### Redis和Memcache的对比和区别

* Redis拥有安全认证的密码机制,Memcache没有

* Redis是内存+硬盘的存储机制存储大小远超memcached的64M

* Redis的1个key最大可以存储1G,而memcached是1M

### Redis的安装和启动

**1.Linux下安装Redis**

`yum -y install redis`

* 当安装完成之后，我们可以使用rpm -ql redis查看redis所有的安装目录和文件的存放位置

**2.启动并登录Redis客户端**

`service redis start|restart|stop`

`redis-cli `

> service redis stop是无法杀死redis的进程的,因为是温柔的结束进程，如果希望杀死redis的进程,我们需要强制杀死redis的进程,命令为pkill redis

#### 1.Redis的String数据类型

**（1）get命令**

* 该命令用于获取Redis中key对应的值，如果key不存在返回 nil,

* 命令语法：get 键名

* 如果一个键名不存在，获取该键名会返回nil(就是英语的null)

**（2）set命令**

* 该命令用于设置或者修改Redis中的键值对

* 命令语法：set 键名(key) 值(value).

#### 2.Redis的hash(哈希表)数据类型

**1）hset命令(hash set)**

* 命令功能:在哈希表中设置一个字段(key)和 一个字段的值(value)

* 命令格式: hset 哈希表的名称 字段(key) 字段值(value)

`hset userInfo:eden name eden`

**2）hget命令**

* 命令功能:在一张指定的哈希表中获取字段的值,如果字段不存在将返回nil

* 命令格式: hget 哈希表的名称 字段名称(key name)

`hget userInfo:eden name`

**3）hmset命令(hash multiple set)**

* 命令功能:在哈希表中设置多个字段(field)和 多个字段的值(value)

* 命令格式: hmset 哈希表的名称 字段(key) 字段值(value)....

`hmget userInfo:eden name eden age 24 sexy male`

**（4）hgetall命令**

* 命令功能:在哈希表获取所有的字段和值

* 命令格式: hgetall 哈希表的名称

**（5）修改值name=jiangliang**

`hset userinfo:eden name jiangliang`

#### 3.Redis的list链表数据类型

**（1）lpush命令（跟栈相关）先进后出**

* 命令功能:在链表的栈中由头部压入一条数据

* 命令格式: lpush 链表的名称(栈名称) 值

```
lpush list1 one

lpush list1 two

lpush list1 three
```

**（2）rpush命令（跟队列相关）先进先出**

* 命令的功能:在链表的队列中由尾部压入一条数据

* 命令格式: rpush 链表的名称(队列) 值

```
lpush list2 one

lpush list2 two

lpush list2 three
```

**（3）lrange命令（跟队列和栈都相关，用于查询）**

* 命令功能:在链表的中获取一个范围（索引的范围）的数据

* 命令格式: lrange 链表的名称 索引开始位置 索引结束位置(-1代表获取到全部)

* 例如:获取一个栈的所有数据,比如获取list1的链表中所有栈的数据

`lrang list1 0 -1`

**（4）lpop命令(与栈和队列相关)**

* 命令的功能:弹出队列中的头部元素或者弹出栈中的头部元素,并且返回其值

* 命令格式: lpop 链表的名称

* 例子1:弹出list2队列中的头部元素并且删除

`lpop list2`

**(5)ltrim命令(一般用于队列操作比较多)**

* 命令的功能:让列表只保留指定区间内的元素，不在指定区间之内的元素都将被删除

* 命令格式: ltrim 链表的名称 开始的位置 结束的位置

`lpop list2 1 3`

### Redis的Set集合数据类型(无序集合)

#### 在现实开发当中集合一般用于社交网站或者社交软件的朋友圈功能(例如:新浪微博好友圈)

**1）sadd命令（set add）**

* 命令的功能:在无序集合当中添加一个元素，该元素如果存在该元素不会被重复添加

* 命令格式: sadd 集合的名称 集合的元素

* 例子1:创建一个名为jiangliang的无序集合,含有元素杨过,小龙女,林朝英

```
 sadd jiangliang yangguo xiaolongnv zhoubotong
```

* 例子1:创建一个名为riling的无序集合,含有元素杨过,小龙女,林朝英

```
 sadd riling yangguo xiaolongnv linchaoying hongqigong
```

**(2)smembers命令**

* 命令功能:查看一个无序集合中的所有的元素

* 命令格式: smembers [无序集合的名称]

**（3）sdiff命令(好友推荐功能)**

* 命令的功能:以一个集合作为标准去求另外一个集合不存在的元素，我们称为差集（可以参考集合概念中差集的图片辅助理解）

* 命令格式: sdiff 作为标准的集合名称 求差集的集合名称

```
127.0.0.1:6379> sdiff riling jiangliang
1) "linchaoying"
2) "hongqigong"
```

**（4）sinter命令**

* 命令的功能:一个集合和另外一个集合共同的元素，我们称为交集（可以参考集合概念中交集的图片辅助理解）

* 命令格式: sinter 集合名称1 集合名称2

```
127.0.0.1:6379> sinter jiangliang riling
1) "xiaolongnv"
2) "yangguo"
```

**（5）sunion命令**

* 命令的功能:求出两个集合合并后所有的元素并去掉重复的元素的结果称为并集（可以参考集合概念中并集的图片辅助理解）

* 命令格式: sunion 集合名称1 集合名称2 ....

```
127.0.0.1:6379> sunion jiangliang riling
1) "yangguo"
2) "xiaolongnv"
3) "zhoubotong"
4) "linchaoying"
5) "hongqigong"
```

**（6）scard命令**

* 命令功能:统计集合中的元素个数，并返回总数的整型值，该命令一般在社交网络中用于统计粉丝数

* 命令格式: scard 集合名称

```
127.0.0.1:6379> scard jiangliang
(integer) 3
```

**(7)srem命令**

* 命令功能:用于删除无序集合中的元素,在社交网络开发中用于黑名单功能

* 命令格式:srem [集合名称][元素名称]

```
127.0.0.1:6379> srem jiangliang yangguo
(integer) 1
```

### Redis的zset集合数据类型(有序集合)

**sorted set是set的一个升级版本，意大利文叫zset，在set的基础上增加了一个顺序属性，这一属性在添加修改元素的时候可以指定，每次指定后，zset会自动重新按新的值调整顺序。**

**（1）zadd 命令**

* 命令功能:向有序集合中添加元素。如果该元素存在，则更新其顺序。

* 在zset当中序号是顺序,索引号是下标,注意区分

* 命令格式: zadd  集合名  序号  元素

**（2）zrange命令 **

* 命令功能:按序号升序(由小到大)获取有序集合中的内容

* 命令格式：zrange 集合名称 开始位置(索引)  结束位置(索引)(-1获取全部)

**（3）zrevrange命令**

* 命令功能:按序号降序(由大到小)获取有序集合中的内容。

* 命令格式：zrevrange 集合名称 开始位置(索引)  结束位置(索引)(-1获取全部)

### **总结:无序集合为了功能而生,但zset集合为了排序而生**

### Redis中与Key相关的命令(管理命令)

**（1）keys * 命令**

* 命令功能:返回当前数据库里面的键(key)

**（2）exists命令**

* 命令功能:判断一个键是否存在。

* 命令格式：exists  键名

**（3）del**+

* 命令功能:删除指定的键(key)，如果返回1代表删除键名成功，返回0代表删除失败

* 命令格式：del  键名

**4）type**

* 命令功能:返回一个键的数据类型

* 命令格式： type  键名

**（5）expire**

* 命令功能:设置键的有效期，如果不调用该命令设置键名，默认的情况下键名本身就是永远不过期。

* 命令格式：expire  键名  有效期(秒数)

**(6)ttl命令**

* 命令作用:查看一个key的过期剩余时间

* 命令格式:ttl 键名

### Redis安全认证

**在默认的情况下redis不需要任何密码就可以登录，任何客户端只要连接6379端口就可以调用redis命令,安全性肯定不够,如果希望提高redis的安全性,我们可以为redis设置一个密码.Redis把设置密码的过程称为安全认证功能(Redis Auth)
密码存放在redis的配置文件中（文件位于/etc/redis.conf）**

**设置安全认证的步骤如下：**

> 第1步:使用vim打开/etc/redis.conf文件，使用末行模式搜索关键字/foobared

> 第2步：把requirepass前的#去除,记得把requirepass进行顶格，并且修改redis的安全认证密码为123456

`requirepass 123456`

> 第3步：如果希望redis的安全认证生效，那么需要重启redis服务器

> 第4步:使用redis-cli命令进行登录，发觉可以进入客户端界面但无法进行操作

> 第5步:使用安全认证密码进行登录查看redis客户端操作结果,发现可以

**安全认证登录命令：redis-cli -a 安全认证密码**

### Redis的持久化AOF设置

> * 在redis当中，redis有两种持久化模式,默认为快照模式(用于保存数据到硬盘的模式)

**1.Redis的快照模式（默认安装完成就会自动开启的持久化模式）**

* 快照文件默认存储以下位置:/var/lib/redis/dump.rdb,使用linux查看,默认情况下快照模式没有利用计算机的内存，只是单方面把数据置于硬盘当中，如果希望redis把硬盘+内存的存储方式利用起来,则要调整为aof模式

**Redis中的Aof模式：**

* 如果开启硬盘+内存方式存储数据，redis默认情况下会先把数据存放到内存中，然后每隔1秒钟就把内存的数据同步到硬盘中

### 我们需要通过编辑/etc/redis.conf文件去开启redis的aof持久化模式,设置aof持久化模式的步骤如下:

* 第1步:使用vim打开/etc/redis.conf文件，通过末行模式搜索/appendonly，得到以下内容：

`appendonly no`

**no表示快照模式，yes表示AOF模式**

* 第2步:把appendonly 的选项由no改为yes，代表开启aof持久化模式,同时需要把appendfilename选项前的#去除，修改如下:

```
appendonly yes

aooendfilename "appendonly.aof"
```

* 第3步:开启完成后，需要重启redis服务器，如下图所示:

`service redis restart`

* 第4步:重启完成后，必须去/var/lib/redis目录下去查看是否具有aof文件的生成

* 如果我们添加数据,发觉aof文件的大小就会改变

### 安装Redis的PHP扩展到PHP5.6

**yum install -y --enablerepo=remi --enablerepo=remi-php56 php-pecl-redis**





