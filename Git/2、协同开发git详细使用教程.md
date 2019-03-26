### GIT多人开发详细教程

#### 主管创建git主仓库
```
git init --bare
```

> ### **不使用分支**

>> 新人开发

#### clone仓库到本地
```
git clone 【远程仓库地址】
```

#### 开发完成后，提交到本地仓库
```
git add ./
```
```
git commit -m"注释"
```
```
git push
```

* or
```
git remote
```
```
git push 【git remote结果】 master
```

### 老员工开发


#### 拉取最新代码
```
git pull
```

#### 开发完成后
```
git add ./
```
```
git commit -m"注释"
```
```
git push
```

#### 如果push遇到错误，说明有人在你提交前更新了代码,再拉取一次
```
git pull
```
```
git push
```


