### GIT多人开发详细教程

#### 主管创建git主仓库
```
git init --bare
```

> ### **独自开发**

```
git clone 【远程仓库地址】
```
```
git add ./
```
```
git commit -m"注释"
```
```
git push
```


> ### **协同开发，不使用分支**

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

>> 老员工开发


#### 拉取最新代码
```
git pull --rebase
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
git pull --rebase
```
```
git push
```

* 一定要实用 `git pull --rebase`，不然会产生节点污染


> ### **协同开发，使用分支**

* 为什么有时候会用到分支呢？这是因为有些功能你只能昨晚之后提交，才不影响别人的业务，如果你每天提交，人家的功能可能就做不了，这时候就需要分支了，当你功能写完，才进行分支合并，这样就不干扰到其他人的开发了

#### 创建分支
```
git brand 【分支名】
```

#### 显示所有分支
```
git brand -a
```

#### 显示当前分支
```
git brand
```

#### 切换分支
```
git chekout 【分支名】
```

> **在分支上开发完成后，要将分支合并到master分支，再推送到远程仓库**

#### 合并分支一定要在本地master上面操作
```
git checkout master
```

#### 合并开发完成的分支
```
git merge 【分支名】
```

#### 删除分支
```
git branch -d 【分支名】
```
