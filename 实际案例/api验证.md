```php
<?php
/**
 * @Author: Shengpeng Li
 * @Date:   2018-04-06 19:16:42
 * @Filename: Api.php
 * @Last modified by:   Shengpeng Li
 * @Last modified time: 2018-04-07 10:38:10
 */

namespace app\api\controller;    

use think\Request;

class Api extends \think\Controller
{
    public function __construct(Request $request)
    {
        if ($request->Controller() !== 'Api') {
            $token = isset($request->post(false)['token'])?$request->post(false)['token']:'';
            // 实例化Redis
            $redis = new \Redis();
            $redis -> connect('localhost',6379);
            $redis -> auth('8G66336951a.');
            if (!$redis -> get($token)) {
                $data = [ 'info' => '信息为空', "status"=> 1 ];
                echo json_encode($data);
                exit;
            }
        }
    }

    /**
     * 通过传入账号密码交换token
     * @param  string $user     账号
     * @param  string $password 密码
     * @return string           token
     */
    public function token(Request $request)
    {
        # 接收post数据
        $post = $request->post(false);
        # 判断
        if (!isset($post['user']) || !isset($post['password'])) {
            $data = [ 'info' => '未指定账户密码', "status"=> 1 ];
            return json($data);
        }
        $user = $post['user'];
        $password = $post['password'];
        if ($user=='root' && $password=='123456') {

            // 实例化Redis
            $redis = new \Redis();
            $redis -> connect('localhost',6379);
            $redis -> auth('8G66336951a.');

            // 使用uuid生成唯一秘钥写入redis中，并设置30分钟后过期
            $hash = password_hash($this->uniqidReal(),PASSWORD_DEFAULT);
            if ($redis -> set($hash,$user) && $redis -> setTimeout($hash, 60 )) {
                $data = [ 'info' => $hash, "status"=> 0 ];
            }else{
                $data = [ 'info' => '系统错误', "status"=> 1 ];
            }

            return json($data);
            // echo json_encode($data);

        } else {
            $data = [ 'info' => '验证失败', "status"=> 1 ];
            return json($data);
        }
    }

    /**
     * 生成唯一的uuid值
     * @param  integer $lenght 生成的uuid长度
     * @return
     */
    public function uniqidReal($lenght = 13)
    {
        if (function_exists("random_bytes")) {
            $bytes = random_bytes(ceil($lenght / 2));
        } elseif (function_exists("openssl_random_pseudo_bytes")) {
            $bytes = openssl_random_pseudo_bytes(ceil($lenght / 2));
        } else {
            throw new Exception("no cryptographically secure random function available");
        }
        return substr(bin2hex($bytes), 0, $lenght);
    }
}

```
