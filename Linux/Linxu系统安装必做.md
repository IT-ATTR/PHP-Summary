# Linxu系统安装必做

### 1.使用yum安装vim
```
yum -y install vim
```

### 2.防范黑客使用单用户模式破解ROOT密码
> 单用户模式这个模式类似于windows的安全模式,主要目的原本是用来维护Linux操作系统的,但是世界上有很多初学者没有设置引导装载密码,导致黑客有机可乘,黑客可以利用单用户模式破解root的登录密码,从而获取root的权限

生成linux的装载引导密码的Md5加密形式
```
[root@localhost ~]# grub-md5-crypt
Password:
Retype password:
$1$LcGNm/$Npw4yM1YxGRQnlIsLctXf.
```
设置装载引导密码到/etc/grub.conf文件当中
```
[root@localhost ~]# vim /etc/grub.conf
```
在【splashimage】【hiddenmenu】中间添加引导密码
```
splashimage=(hd0,0)/grub/splash.xpm.gz
password $1$LcGNm/$Npw4yM1YxGRQnlIsLctXf.
hiddenmenu
```

### 3.关闭Linux子安全系统selinux
>selinux是为安全而生,但是由于selinux对于php开发来说是一个好心做坏事的家伙,原因selinux会阻碍ftp,composer,sphinx和redis和memcache,mongdb在php当中的运行,也会阻碍数据库主从同步,因此我们需要把selinux关闭掉

使用vim打开selinux的配置文件
```
[root@localhost ~]# vim /etc/selinux/config
```
把Selinux修改为disabled,保存并退出(:x),必须重启linux才能真正关闭Selinux
```
SELINUX=disabled
```

### 4.关闭Linux的防火墙机制
由于防火墙会影响php的开发所以我们需要关闭防火墙
```
# 防火墙相关指令
service iptables [start|restart|stop|status]
```
关闭防火墙且将防火墙加入自关闭脚本(重启开启服务器自关闭防火墙)
```
[root@localhost ~]# service iptables stop
[root@localhost ~]# chkconfig iptables off
```
查看防火墙情况
```
[root@localhost ~]# service iptables status
```

## 修改Linux系统中的时间
```bash
# 修改系统时间
[root@localhost ~]# date -s 20180326
[root@localhost ~]# date -s 20:03:00
# 硬件时间同步系统时间
[root@localhost ~]#	clock --systohc
```
