# ORM操作

通过工匠指令创建模型并引入
```php
use App\Models\NewsModel;
```

## 模型基础
```php
class NewsModel extends Model{
    protected $table = '表名';
    protected $primaryKey = '主键';
    // 是否需要laravel维护 created_at 和 updated_at 表字段 默认true
    public $tiemstamps = false;
    // orm模型中加入字段白名单
    protected $filltable = ['title','content'];
}
```

## 添加
### 兼容模式
```php
public function f_save(NewsModel $news)
{
    $news -> title = '这是一条兼容模式下插入的标题';
    $news -> content = '这是一条兼容模式下插入的内容';
    $news -> save();
}
```

### 主流模式
```php
# 控制器方法
public function f_save()
{
    NewsModel::create(['title'=>'添加标题','content'=>'添加内容']);
}
```

## 删除
```php
public function delete()
{
    # 根据主键进行删除
    NewsModel::find(2)->delete();
    # 根据字段的条件删除
    NewsModel::where('title','标题条件')->delete();
}
```

## 修改
```php
public function update()
{
    # 根据主键进行修改
    NewsModel::find(2)->update(['title'=>'标题']);
    # 根据字段的条件进行修改
    NewsModel::where('title','标题条件')->update(['title'=>'标题']);
}
```

## 查询
```php
public function read()
{
    # 根据主键获取唯一数据
    $data = NewsModel::find(2);
    return view('test') ->with('data'=>$data);

    # 获取所有数据
    $data = NewsModel::all();
    return view('test') ->with('data'=>$data);

    # 获取所有数据并转化成数组
    $data = NewsModel::all()->toArray();
    return $data;

    # 根据条件获取数据
    $data = NewsModel::where('title','条件')->get();

    # 获取首条数据
    $data = News::first();
}
```

## 查询分页
```php
$popedom->orderBy('字段','asc or desc')->offset('跳过多少条数据')->limit('查询多少条数据')->get()
```
