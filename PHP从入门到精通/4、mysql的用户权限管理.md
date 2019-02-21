## mysql的用户权限管理
#### 查看myslq中的管理员账号
```
>mysql -uroot -p123456
>show databases
>use mysql
>show tables
>select * from user where 1

可以看到有一个root用户，也就是mysql默认的登录账号
```
#### 新增用户
```
create user '账号'@'IP地址' identified by '原始密码'
```

```
create user 'kalven'@'localhost' identified by '123456'
```

#### 修改用户密码
```
set  password  for  ‘帐号’@’IP地址’ =password(‘新密码’)
```

```
set  password  for  'kaleven'@'localhost' =password('654321')
```

#### 修改自己的密码
```
set  password=password(‘新密码’)
```

#### 更新密码之后还需要进行刷新
```
flush  privileges
```

#### 删除用户
```
drop user '账号'@'IP地址'
```

#### 为用户授权
```
grant  权限1[, 权限2, …, 权限n]  on  库名.表名  to  ‘帐号’@’IP地址’
```

```
grant select on db_1.stu to 'kalven'@'localhost'(分配查询权限)
```

#### 收回权限
```
revoke 权限1[, 权限2, …, 权限n]  on  库名.表名  from  ‘帐号’@’IP地址’;’
```

```
revoke select on db_1.stu from 'kalven'@'localhost'(分配查询权限)
```

#### 展示权限
```
show  grants  for  ‘帐号’@’IP地址
```

```
show  grants  fot  'kalven'@'localhost'
```

