# laravel安装easywechat

## 安装

```shell
composer require "overtrue/laravel-wechat:~4.0"
```

## 配置

1.在 config/app.php 注册 ServiceProvider 和 Facade (Laravel 5.5 无需手动注册)

```php
'providers' => [
    // ...
    Overtrue\LaravelWeChat\ServiceProvider::class,
],
'aliases' => [
    // ...
    'EasyWeChat' => Overtrue\LaravelWeChat\Facade::class,
],
```

2.创建配置文件：

```shell
php artisan vendor:publish --provider="Overtrue\LaravelWeChat\ServiceProvider"
```

3.根据应用根目录下的 config/wechat.php 中对应的参数即可。实际是在.env文件上添加如下代码
```
WECHAT_OFFICIAL_ACCOUNT_APPID=
WECHAT_OFFICIAL_ACCOUNT_SECRET=
WECHAT_OFFICIAL_ACCOUNT_TOKEN=
WECHAT_OFFICIAL_ACCOUNT_AES_KEY=
```

4.每个模块基本都支持多账号，默认为 default

## 测试

编写路由代码测试(访问是否能够查看到关注用户列表)
```php
Route::get('/', function () {
    $app = app('wechat.official_account');
    dd($app->user->list());
});
```
