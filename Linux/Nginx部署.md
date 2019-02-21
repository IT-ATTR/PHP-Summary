# Nginx部署

## 安装Nginx

### 安装MySql5.1.73和wget
```bash
[root@localhost ~]# yum -y install wget
# 这里安装mysql略显简陋，详情查看同目录 【yum安装mysql5.7.md】或者【CentOS6.5服务器部署.md】
[root@localhost ~]# yum -y install mysql mysql-server mysql-devel
```

### 下载atomic协议脚本,因为nginx需要同意该脚本才能使用yum安装
```bash
[root@localhost ~]# cd /usr/local/src
[root@localhost src]# wget http://www.atomicorp.com/installers/atomic
[root@localhost src]# chmod 777 atomic
# 执行，第一个填入yes然后一路下一步
[root@localhost src]# ./atomic
```

### 更新nginx当前版本的yum源
```bash
[root@localhost ~]# yum check-update
```

### 安装Nginx，使用以下安装命令
```bash
[root@localhost ~]# yum -y install nginx
```

### 把nginx相关的脚本(nginx_cn.zip和nginx.sh)上传到/usr/local/src目录下,设置权限并执行
> 文件保存在当前文件夹Nginx脚本中

```bash
# 先安装解压工具
[root@localhost src]# yum -y install zip unzip
[root@localhost src]# chmod 777 nginx.sh
[root@localhost src]# ./nginx.sh
```

### 启动nginx并加入自启
```bash
[root@localhost src]# service nginx start;
[root@localhost src]# chkconfig nginx on
```

### 在/var/www/html目录下创建index.html并访问nginx是否安装成功

---

## 部署Nginx

> 全局配置的文件的路径: /etc/nginx/nginx.conf<br/>
> 子配置文件的路径: /etc/nginx/conf.d/default.conf

## 配置gzip压缩
使用vim打开/etc/nginx/nginx.conf,把该文件的配置修改如下:
```
#是否启动gzip压缩,on代表启动,off代表开启
gzip  on;
#需要压缩的常见静态资源
gzip_types text/plain application/javascript   application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
#由于nginx的压缩发生在浏览器端而微软的ie6很坑爹,会导致压缩后图片看不见所以该选项是禁止ie6发生压缩
gzip_disable "MSIE [1-6]\.";
#如果文件大于1k就启动压缩
gzip_min_length 1k;
#以16k为单位,按照原始数据的大小以4倍的方式申请内存空间,一般此项不要修改
gzip_buffers 4 16k;
#压缩的等级,数字选择范围是1-9,数字越小压缩的速度越快,消耗cpu就越大
gzip_comp_level 2;
```
重启nginx
```bash
# 检查语法
[root@localhost src]# nginx -t
# 重新装置配置文件
[root@localhost src]# nginx -s reload
```
在/var/www/html下编写一个超过1K的文件，并访问，查看gzip压缩是否生效【Content-Encoding: gzip】
```bash
[root@localhost src]# curl -I -H "Accept-Encoding: gzip, deflate" "http://192.168.56.100"
```

## 使用缓存功能把静态资源缓存到客户端

### 1.启动缓存功能的配置如下
```bash
[root@localhost src]# vim /etc/nginx/conf.d/default.conf
```
```
location ~ .*\.(jpg|jpeg|gif|css|png|js|ico|mp3|mp4|swf|flv){
    # 这里配置缓存10天
    expires 10d;
}
```
重启nginx 并测试图片是否被缓存
```bash
# 检查语法
[root@localhost src]# nginx -t
# 重新装置配置文件
[root@localhost src]# nginx -s reload
[root@localhost src]# curl -I -H "Accept-Encoding: gzip, deflate" "http://192.168.56.100/1.jpg"
```
> 如果linux时间不对要修改linux中的系统时间和硬件时间,否则缓存有问题

## 实现负载均衡的反向代理

### 修改反向代理服务器(Nginx)的/etc/nginx/nginx.conf文件内容
```
#负载均衡的反向代理分发选项
upstream web{
    # weight=1 : 权重如果分配的值越大,权重越高
    # weight=1 : 权重如果分配的值越大,权重越高
    # fail_timeout=20s : 每次连接失败的时间
    server 192.168.56.2 weight=1 max_fails=3 fail_timeout=20s;
    server 192.168.56.3 weight=1 max_fails=3 fail_timeout=20s;
}
```
### 修改反向代理服务器(Nginx)的/etc/nginx/conf.d/default.conf文件内容
反向代理到upstream web节点,同时把本地的节点注解
```
#location / {
   # index  index.php index.html index.htm;
#}
location / {
    proxy_pass http://web/;
}
```
重启nginx
```bash
# 检查语法
[root@localhost src]# nginx -t
# 重新装置配置文件
[root@localhost src]# nginx -s reload
```

### 检查配置是否成功
在被代理服务器上建立两个不一样内容的index文件后，直接访问代理服务器(Nginx服务器),每次访问刷新都

## 实现lnmp部署
> lamp为算法而生,所以如果一个网站的逻辑非常复杂,例如:股票交易,金融等适合采用lamp架构,lnmp为访问量而生,如果访问量比较大适合采用lnmp,目前的流行的lamp+lnmp两者结合使用

### 安装php5.6x
更换安装源
```bash
[root@localhost ~]# rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
[root@localhost ~]# rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
```
由于nginx是靠php-fpm来启动php的,所以必须首先安装php-fpm,安装命令如下:
```bash
[root@localhost ~]# yum -y install --enablerepo=remi --enablerepo=remi-php56 php-fpm
```
正式安装php5.6
```bash
[root@localhost ~]# yum -y install --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-pecl-xdebug php-pecl-xhprof
```

### 如果希望搭建lnmp环境,那么nginx就不能具备upsteam选项(负载均衡的功能)
> 如果我们有配置过负载均衡,那么就需要把upstream选项全部注解起来

修改服务器(Nginx)的/etc/nginx/nginx.conf文件内容
```
# 负载均衡的反向代理分发选项
# upstream web{
    # server 服务器地址 weight=1 max_fails=3 fail_timeout=20s;
    # server 服务器地址 weight=1 max_fails=3 fail_timeout=20s;
# }
```
修改服务器(Nginx)的/etc/nginx/conf.d/default.conf文件内容
```
location / {
   index  index.php index.html index.htm;
}
# location / {
    # proxy_pass http://web/;
#}
```
如下相关配置，第一个URL不支持重写，第二个支持URL重写，视项目情况打开所需的配置
```
#location ~ \.php$ {
    #fastcgi_pass   127.0.0.1:9000;
    #fastcgi_index  index.php;
    #fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    #include        fastcgi_params;
#}
#location ~ .+\.php($|/) {
    #set $script    $uri;
    #set $path_info  "/";
    #if ($uri ~ "^(.+\.php)(/.+)") {
        #set $script     $1;
        #set $path_info  $2;
    #}
    #fastcgi_pass 127.0.0.1:9000;
    #fastcgi_index  index.php?IF_REWRITE=1;
    #include fastcgi_params;
    #fastcgi_param PATH_INFO $path_info;
    #fastcgi_param SCRIPT_FILENAME  $document_root/$script;
    #fastcgi_param SCRIPT_NAME $script;
#}
```
保存并退出(:x),但暂时不要重启nginx服务器,可以使用nginx -t查看语法是否修改正确

### 修改php-fpm的相关配置, vim /etc/php-fpm.d/www.conf
```
use = nginx
group = nginx
```

### 重启nginx，启动php-fpm
```bash
# 检查语法
[root@localhost src]# nginx -t
# 重新装置配置文件
[root@localhost src]# nginx -s reload

[root@localhost ~]# service php-fpm start
[root@localhost ~]# chkconfig php-fpm on
```

在nginx服务器代理服务新建文件 /var/www/html/phpinfo.php 打印phpinfo(),配置完成
`FPM/FastCGI`
