<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/10/22
 * Time: 15:55
 */

namespace app\api\controller;


use think\Controller;
use think\Db;

class Upload
{

    //图片上传
    public function uploadFile()
    {
        // 获取表单上传文件 例如上传了001.jpg
        $head = request()->file('file');
        // $clubId = request()->param('clubId');
        // if(empty($clubId)){
        //     exit(json_encode(['code' => 1012,'data'=>'','message' => 'clubId参数错误','success'=> false],JSON_UNESCAPED_UNICODE));
        // }
        if(empty($head)){
            exit(json_encode(['code' => 1012,'data'=>'','message' => 'head参数错误','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        // $exists = Db::name('club')->where('clubId', $clubId)->find();
        // if (!$exists) {
        //     exit(json_encode(['code' => 1012, 'data' => '', 'message' => '俱乐部不存在', 'success' => false], JSON_UNESCAPED_UNICODE));
        // }

        // 移动到框架应用根目录/public/uploads/ 目录下
        if($head){
            $info = $head->move(ROOT_PATH . 'public' . DS . 'uploads');
            if($info){
                // 成功上传后 获取上传信息
                // 输出 jpg
//                echo $info->getExtension();
                // 输出 20160820/42a79759f284b767dfcb2a0197904287.jpg
                $fileName = str_replace('\\', '/', $info->getSaveName());
                $fileName = $_SERVER['HTTP_HOST'].'/uploads/'.$fileName;

                // $admin = Db::name('club_user')->where('wechatUserId',$this->user['id'])->where('clubId',$clubId)->find();
                // if(!$admin){
                //     exit(json_encode(['code' => 1012,'data'=>'','message' => '权限不足,无法修改','success'=> false],JSON_UNESCAPED_UNICODE));
                // }
                // if( (isset($admin['isCreator']) && $admin['isCreator']==0) &&  (isset($admin['isManager']) && $admin['isManager']==0) ){
                //     exit(json_encode(['code' => 1012,'data'=>'','message' => '权限不足,无法修改','success'=> false],JSON_UNESCAPED_UNICODE));
                // }

                // try{
                //     Db::name('club')->where('clubId',$clubId)->update(['head'=>$fileName]);
                // }catch (\Exception $e){
                //     exit(json_encode(['code' => 1012,'data'=>'','message' => $e->getMessage(),'success'=> false],JSON_UNESCAPED_UNICODE));
                // }

                exit(json_encode(['code' => 200, 'data' => $fileName, 'message' => '请求成功', 'success' => true], JSON_UNESCAPED_UNICODE));
                // 输出 42a79759f284b767dfcb2a0197904287.jpg
//                echo $info->getFilename();
            }else{
                // 上传失败获取错误信息
                exit(json_encode(['code' => 1012,'data'=>'','message' => $head->getError(),'success'=> false],JSON_UNESCAPED_UNICODE));
            }
        }
    }
}