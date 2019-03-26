### 添加ssh Key到git

> ### 配置git基本信息
```
git config --global user.name "user.name"
```
```
git config --global user.email "user.email"
```

> ### 查看git是否生成公钥
```
cd ~/.ssh
```
```
ls
```

> ### 如果存在id_rsa.pub,请跳过这一步，或者先删除其中的公钥
```
rm -rf id_rsa*
```

> ### 重新生成公钥
```
ssh-keygen -t rsa -C "【你的邮箱地址】"
```
* 例如
```
ssh-keygen -t rsa -C "jiangliangscau@163.com"
```
> ### 直接按下回车，生成id_rsa和 id_rsa.pub文件。其中id_rsa.pub就是公钥,将其复制到你网站中年的ssh中
```
$ clip < ~/.ssh/id_rsa.pub
```

* or 
```
cat ~/.ssh/id_rsa.pub
```

> ### 这里以gitlab为例,添加完成后，输入
```
ssh -T git@gitlab.tanwan.com
```

> ### 显示以下信息即是成功
```
Welcome to GitLab, @xxxx!
```




