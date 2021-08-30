<?php
namespace app\api\controller;
use think\Controller;
use think\Db;
use think\Request;

class Common extends Controller
{
    protected $token;
    protected $openid;
    protected $user;

    public function __construct()
    {
        parent::__construct();

        $token =  $this->request->header('Authorization');
        if(!$token){
            exit(json_encode(['code' => 1017, "message"=> "token不能为空",
                "success"=> false]));
        }
        $user = Db::name('user')->where('token', $token)->find();
        // var_dump($user);
        if($user){
            //验证token有效期
            if((time()-$user['token_time']) > 7200){
                exit(json_encode(['code' => 1017, "message"=> "token已过期,请重新登录",
                    "success"=> false],JSON_UNESCAPED_UNICODE));
            }else{
                Db::name('user')->where('token', $token)->update(['token_time'=>time()]);
                $this->openid = $user['openid'];
                $this->user = $user;
                return true;
            }
        }else{
            exit(json_encode(['code' => 1017, 'data'=>'',"message"=> "token验证错误",
                "success"=> false],JSON_UNESCAPED_UNICODE));
        }
    }

    public function checkOpenid(){
        $appid = config('wxpay.appid');
        $secret = config('wxpay.secret');
        $js_code = input('code','');
        // $js_code = 123;
        // $openid = input('openid','');//用户请求过来的值

        $url = 'https://api.weixin.qq.com/sns/jscode2session';
        $data = array(
            'appid' => $appid,
            'secret' => $secret,
            'js_code' => $js_code,
            'grant_type' => 'authorization_code',
        );

        $res = httpRequest($url, 'POST', $data);
        //输出测试，正式使用请删除下面一行
        //输出{"session_key":"GxT18piX7JEvUhazrrcsxw==","openid":"oEE2t4n0eerWnb2mNShyK2ttXLc0"}
        // file_put_contents("../log.txt", $res, FILE_APPEND);

        $obj = json_decode($res); //返回数组或对象

        if(!isset($obj->openid)){
            exit(json_encode(['code' => 1101, 'message' => 'openid获取失败,'.json_encode($obj),'success'=> false],JSON_UNESCAPED_UNICODE));
        }
        return $obj->openid;
    }

    // 重置token
    public function resetToken($openid){
        $data['token'] = getRandChar(32);
        $data['token_time'] = time();
        $result = Db::name('user')->where('openid', $openid)->update($data);
        if($result){
            return $data['token'];
        }else{
            exit(json_encode(['code' => 1101, 'message' => 'token更新失败','success'=> false],JSON_UNESCAPED_UNICODE));
        }
    }

    // 校验token
    public function checkToken(){
        $openid = input('openid', '');
        $token = input('token', '');
        $user = Db::name('user')->where('openid', $openid)->where('token', $token)->find();
        if($user){
            //验证token有效期
            if((time()-$user['token_time']) > 7200){
                return false;
            }else{

                return true;
            }
        }else{
            return false;
        }
    }

}
