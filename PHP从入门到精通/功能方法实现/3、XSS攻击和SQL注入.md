## XSS攻击
**通常用户在表单界面输入的内容是不确定的，用户可以输入任何想要输入的内容进行提交，如果输入的是一些代码，并且我们在程序文件中还没有对用户输入提交的数据进行任何的过滤处理的话，那么，将会面临一定风险。**

#### 初步防御
* 通过使用htmlspecialchars函数进行一级转换过滤，将特殊符号转换实体字符。
```php
$str = htmlspecialchars($_POST['content']);
```


## SQL注入
**什么是SQL注入**
* 在登陆的表单页面随便写了密码，帐号如下图通过一个特殊的结构来构建，要求验证码必须写正确，

#### 使用正则表达式和addslashes转义功能。
```php
$str = addslashes($_POST['content']);
```

#### 使用pdo预处理技术
* 使用SQL语句的预处理技术，能有效阻止SQL注入攻击，在进行语句查询时，使用占位符进行预处理操作，是杜绝SQL注入的绝佳途径。

#### 通过逻辑判断进行防御
* 搭配正则判断有效阻止逻辑判断进行防御，这是比较好的行为，不要相信用户输入的任何字符，对用户输入的任何字符都要进行逻辑判断，是防御的一部分，为什么一些网站上面BUG不断，是和写代码的人有着很大的关系，就是在写代码的时候不能什么事情都能考虑的到，因此会造成网络漏洞，导致网站经不起黑客的简单攻击！

* 可以通过用户输入的账号将数据库中的密码查询出来，然后将用户的输入的密码与数据库中的密码进行匹配，这样比一次同时比较密码和账户来的安全，有效的防御SQL注入！！！
