### GIT���˿�����ϸ�̳�

#### ���ܴ���git���ֿ�
```
git init --bare
```

> ### **���Կ���**

```
git clone ��Զ�ֿ̲��ַ��
```
```
git add ./
```
```
git commit -m"ע��"
```
```
git push
```


> ### **Эͬ��������ʹ�÷�֧**

>> ���˿���

#### clone�ֿ⵽����
```
git clone ��Զ�ֿ̲��ַ��
```

#### ������ɺ��ύ�����زֿ�
```
git add ./
```
```
git commit -m"ע��"
```
```
git push
```

* or
```
git remote
```
```
git push ��git remote����� master
```

>> ��Ա������


#### ��ȡ���´���
```
git pull --rebase
```

#### ������ɺ�
```
git add ./
```
```
git commit -m"ע��"
```
```
git push
```

#### ���push��������˵�����������ύǰ�����˴���,����ȡһ��
```
git pull --rebase
```
```
git push
```

* һ��Ҫʹ��  `git pull --rebase`����Ȼ������ڵ���Ⱦ


> ### **Эͬ������ʹ�÷�֧**

* Ϊʲô��ʱ����õ���֧�أ�������Ϊ��Щ������ֻ������֮���ύ���Ų�Ӱ����˵�ҵ�������ÿ���ύ���˼ҵĹ��ܿ��ܾ������ˣ���ʱ�����Ҫ��֧�ˣ����㹦��д�꣬�Ž��з�֧�ϲ��������Ͳ����ŵ������˵Ŀ�����

#### ������֧
```
git brand ����֧����
```

#### ��ʾ���з�֧
```
git brand -a
```

#### ��ʾ��ǰ��֧
```
git brand
```

#### �л���֧
```
git chekout ����֧����
```

> **Ҫ����֧�ϲ���master��֧�������͵�Զ�ֿ̲�**

#### �ϲ���֧һ��Ҫ�ڱ���master�������
```
git checkout master
```

#### �ϲ�������ɵķ�֧
```
git merge ����֧����
```

#### ɾ����֧
```
git branch -d ����֧����
```

#### Ȼ��������Ŀ��Զ�̷���������
```
git push
```

> **���ֱ���ͷ�֧���͵�Զ�̷������Ļ��������²���**

#### �������л���֧
```
git checkout -b dev
```
* �൱��
```
git branch dev
git checkout dev
```

#### �ύ�÷�֧��Զ�ֿ̲�
```
git push origin dev
```

#### ���Դ�Զ�̻�ȡ��֧
```
git pull origin dev
```

#### ����git push,pullĬ�ϵ��ύ��ȡ��֧,�����ͺܷ����ʹ��git push��git pull����
```
git branch --set-upstream-to=origin/dev
```

#### ȡ����master�ĸ���
```
git branch --unset-upstream master
```

#### ��ʱ�޸��ļ���git add,commit������ύ��Զ�̵�dev������Զ��master