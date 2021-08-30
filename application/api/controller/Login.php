<?php

namespace app\api\controller;

use think\Controller;
use think\Db;

// +----------------------------------------------------------------------
// | openId
//   wx.login ——code(登录凭证，每次变化)——网络请求——openId（唯一标识，同用户同一个小程序唯一的）
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------
// | 用户注册及登录
//   后台接收(code+openId)——后台单独获取openId——进行对比——正确：判断数据库存在openId，存在即登录——重置token并返回
//                                                                                不存在即注册——生成token
//                                                   ——错误：返回信息并要求用户重登录
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------
// | 有权限的接口调用
//   后台接收(openId+token[在有效期内])——数据库进行验证——正确：走其他业务逻辑、错误：要求用户重登录
// +----------------------------------------------------------------------

class Login extends NotAuth
{
    //登录注册
    public function getUser()
    {
        $arr = $this->checkOpenid(); //获取openid;
        $openid= $arr['openid'];
        $session_key= $arr['session_key'];

        $user = Db::name('user')->where('openid', $openid)->find();

        if (!$user) {
            $data = ['openid' => $openid, 'reg_time' => date('Y-m-d H:i:s')];
            $id = Db::name('user')->strict(false)->insertGetId($data);
        }else{
            Db::name('user')->where('openid', $openid)->update(['session_key'=>$session_key]);
        }

        // 重置token
        $token = $this->resetToken($openid);

        exit(json_encode(['code' => 200, 'data' => ['opneid'=>$openid,'token'=>$token], "message"=> "请求成功",
   "success"=> true],JSON_UNESCAPED_UNICODE));

    }



}
