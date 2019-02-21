# 微信的access_token凭证

## Memcached优化access_token的请求

修改`WeChat.class.php`
```php
<?php
public function GetAccessToken(){
    $redis = new Redis();
    $redis -> connect('localhost',6379);
    $redis -> auth('123456');
    $redis -> select(2);
    if ( $redis -> get('access_token') ) {
        return $redis -> get('access_token');
    }else{
        $api = WeChatApi::getApiUrl('api_access_token');
        $res = $this->CurlRequest($api);
        $json = json_decode($res);
        $access_token = $json ->access_token;	//获取access_token
        $redis -> set('access_token',$access_token);
        $redis -> setTimeout('access_token',3600);
        return $access_token;
    }
}
```
