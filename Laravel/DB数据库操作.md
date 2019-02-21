# DB数据库操作

## 设置数据库参数|`.env`文件
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_DATABASE=数据库名
DB_USERNAME=用户名
DB_PASSWORD=密码
```

## 引入DB类
```php
use Illuminate\Support\Facades\DB;
```

## 基本操作
```php
# 插入数据操作
$data = [
    'name' => 'zjlsp',
    'age' => 20
]
DB::table('tableName')->insert($data);

# 查询所有数据
DB::table('tableName')->get();

# 查询第一条数据
DB::table('tableName')->first();

# 修改数据
$data = [ 'name' => 'zjlsp', 'age' => 20 ];
DB::table('tableName') -> where('id','=','2') -> update($data);

# 删除数据
DB::table('tablename') -> where('id','=','2') -> delete();
```

## 高级查询
```php
# and查询操作
DB::table('tablename') -> where('sex','男') -> where('age','>','18') -> get();

# or查询操作
DB::table('tablename') -> where('sex','男') -> orWhere('age','>','18') -> get();

# in查询操作
DB::table('talbename') -> whereIn('id',[1,3,5,7,9]) -> get();

# 使用原生sql语句查询
DB::select($sql);

# 使用预处理查询
$sql = "insert into tableName(name,age) values(:name,:age)";
DB::select($sql,[':name'=>'zjlsp','age'=>'20']);
```
