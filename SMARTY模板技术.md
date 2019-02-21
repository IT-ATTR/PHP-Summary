# SMARTY模板技术

部署

```php
// 引入smarty核心库文件
include './smarty/Smarty.class.php';
// 实例化smarty
$smarty = new Smarty;
```

修改定界符

```php
$smarty -> left_delimiter = '<!-- ';
$smarty -> right_delimiter = ' -->';
```

目录设置

```php
// Smarty2.0版本
$smarty -> template_dir = '';    // 模板目录，默认为templates
$smarty -> compile_dir = '';     // 编译目录，默认的是templates_c
$smarty -> config_dir = '';      // 配置目录，默认为configs
$smarty -> cache_dir = '';       // 缓存目录，默认为cache

// Smarty3.0以后的版本
$smarty -> setTemplateDir();     // 修改模板目录
$smarty -> setCompileDir();      // 修改编译目录
$smarty -> setConfigDir();       // 修改配置目录
$smarty -> setCacheDir();        // 修改缓存目录
```

分配变量 渲染模板

```php
$smarty -> assign('title','标题');
$smarty -> display('index.html');
```

向下兼容smarty老版本路径方法

```php
define('SMARTY_DIR',dirname('__FILE__').'/smarty/');
```

模板注释

    {* smarty模板注释 *}

系统变量

    {$smarty.get.变量名}
    {$smarty.post.变量名}
    {$smarty.cookies.变量名}
    {$smarty.session.变量名}
    {$smarty.const.常量名}
    {$smarty.now} // 时间戳

循环

    {foreach from=$list key='list_key' item='value'}
        {$value.name}
        {$value.age}
        {$list_key}     // 循环的下标
        {$smarty.foreach.value.index}       // 索引值 0开始
        {$smarty.foreach.value.iteration}   // 遍历次数 1开始
    {foreachelse}
        暂无数据
    {/foreach}

文件包含

    {include file='header.html' 额外分配的变量=变量值 title='标题'}

判断

    {if $age>=30}
        中年人
    {elseif $age>=18}
        成年人
    {else}
        未成年
    {/if}

排除解析

    {literal}
        在这里的变量将不会被解析
    {/literal}

输出左右定界符

    {ldelim}
    {rdelim}

变量调节器

    拼接字符串
    {$var|cat:'拼接字符'}

    时间格式转换
    {$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}

    设置默认值
    {$var|default:'暂无数据'}

    转换成大写或者小写
    {$var|upper}
    {$var|lower}

    不渲染html
    {$html|escape}

    换行转实体字符
    {$html|nl2br}

    清除html标签
    {$html|strip_tags}
