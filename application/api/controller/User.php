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

class User extends Common
{
    //更新用户微信信息
    public function register()
    {
        $data['nickname'] = input('nickname', '');
        $data['avatarurl'] = input('avatarurl', '');
        $data['gender'] = input('gender', '');
        $data['city'] = input('city', '');
        $data['province'] = input('province', '');
        $data['country'] = input('country', '');
        $data['language'] = input('language', '');

        $id = Db::name('user')->where('openid',$this->openid)->update($data);

        exit(json_encode(['code' => 200, 'data'=>'','message' => '请求成功','success'=> true],JSON_UNESCAPED_UNICODE));

    }

    //更新用户信息
    public function updateUserInfo()
    {
        $data['userName'] = input('userName', '');
        $data['userGender'] = input('userGender', '');
        $data['userPhone'] = input('userPhone', '');
        $data['userIdCard'] = input('userIdCard', '');
        $data['userHead'] = input('userHead', '');

        $id = Db::name('user')->where('id',$this->user['id'])->update($data);

        exit(json_encode(['code' => 200, 'data'=>'','message' => '请求成功','success'=> true],JSON_UNESCAPED_UNICODE));

    }

    //获取用户信息
    public function getUserInfo()
    {
        $data = Db::name('user')->where('id',$this->user['id'])->field(['userHead','userName','userPhone ','userIdCard','userGender'])->find();

        exit(json_encode(['code' => 200, 'data'=>$data,'message' => '请求成功','success'=> true],JSON_UNESCAPED_UNICODE));

    }

    //获取创建俱乐部申请记录
    public function getOwnClubApplys()
    {
        $page = input('page', '');
        $rows  = input('rows', 10);

        $data = Db::name('club')->where('wechatUserId',$this->user['id'])
            ->field(['checkContent','checkStatus','checkTime','createTime','clubId as id','name','openid','updateTime','wechatUserId'])->paginate($rows)->toArray();

        exit(json_encode(['code' => 200, 'data'=>['total'=>$data['total'],'rows'=>$data['data']],'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));

    }

    //获取创建俱乐部列表
    public function getOwnClubs()
    {
        $page = input('page', '');
        $rows  = input('rows', 10);

        $data = Db::name('club')->where('fox_club.wechatUserId',$this->user['id'])
            ->join('fox_club_user','fox_club_user.clubId=fox_club.clubId','left')
            ->join('fox_activity','fox_activity.clubId=fox_club.clubId','left')
            ->field(["fox_club.createTime","fox_club.clubId as id","fox_club.name","fox_club.wechatUserId","fox_club.head","concat(fox_club.province,',',fox_club.city,',',fox_club.area) as address","fox_club.checkStatus","count(fox_club_user.id) as userNum","count(fox_activity.id) as actNum"])->paginate($rows)->toArray();

        if($data['total']==0){
            exit(json_encode(['code' => 200, 'data'=>['total'=>$data['total'],'rows'=>null],
                'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
        }else{
            foreach($data['data'] as $k=>&$v){
                $userNum = Db::name('club_user')->where('clubId',$v['id'])->count();
                $v['userNum'] = $userNum;
                $actNum = Db::name('activity')->where('clubId',$v['id'])->count();
                $v['actNum'] = $actNum;
            }

            exit(json_encode(['code' => 200, 'data'=>['total'=>$data['total'],'rows'=>$data['data']],
                'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
        }


    }

    //申请加入俱乐部
    public function applyClub()
    {
        $data['clubId'] = input('clubId');
        $data['userName'] = input('userName','');
        $data['userGender'] = input('userGender');
        $data['userPhone'] = input('userPhone ','');
        $data['userIdCard'] = input('userIdCard','');

        if(!isset($data['clubId'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,clubId不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        $data['wechatUserId'] = $this->user['id'];
        $data['openid'] = $this->user['openid'];
        $data['createTime'] = date('Y-m-d H:i:s');

        $club = Db::name('club')->where('clubId',$data['clubId'])->find();
        if(!$club){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '该俱乐部不存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        $clubUser = Db::name('club_user')
            ->where('clubId',$data['clubId'])
            ->where('wechatUserId',$data['wechatUserId'])
            ->where('status',0)
            ->find();

        if($clubUser){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '已加入该俱乐部','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $clubUser = Db::name('club_user')
            ->where('clubId',$data['clubId'])
            ->where('wechatUserId',$data['wechatUserId'])
            ->find();

        if($clubUser){
            Db::name('club_user')
                ->where('clubId',$data['clubId'])
                ->where('wechatUserId',$data['wechatUserId'])
                ->update(['status'=>0]);
        }else{
            Db::name('club_user')->insert($data);
        }


        exit(json_encode(['code' => 200, 'data'=>'',
            'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));

    }

    //获取已加入的俱乐部列表
    public function getJoinClubs()
    {
        $page = input('page', '');
        $rows  = input('rows', 10);

        $data = Db::name('club_user')
            ->join('fox_club','fox_club.clubId=fox_club_user.clubId')
            ->join('fox_club_user a','a.clubId=fox_club.clubId','left')
            ->where('fox_club_user.wechatUserId',$this->user['id'])
            ->group('fox_club.clubId')
            ->field(["fox_club.clubId",'fox_club.createTime','fox_club.clubId as id','fox_club_user.isCreator','fox_club_user.isManager','fox_club_user.createTime as joinTime','fox_club.name','fox_club.wechatUserId','fox_club.head'])
            ->paginate($rows)->toArray();
        if($data['total'] ==0){
            exit(json_encode(['code' => 200, 'data'=>['total'=>$data['total'],'rows'=>null],
                'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
        }else{
            foreach($data['data'] as $k=>&$v){
                $userNum = Db::name('club_user')->where('clubId',$v['clubId'])->count();
                $v['userNum'] = $userNum;
                $actNum = Db::name('activity')->where('clubId',$v['clubId'])->count();
                $v['actNum'] = $actNum;
            }
            exit(json_encode(['code' => 200, 'data'=>['total'=>$data['total'],'rows'=>$data['data']],
                'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
        }
    }

    //人员授权
    public function userAuth()
    {
        $clubId = input('clubId');
        $id = input('id');
        $isManager = input('isManager');
        $isDelete = input('isDelete');

        if(!isset($clubId)){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,clubId不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $exist = Db::name('club')->where('clubId',$clubId)->find();
        if(!$exist){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '该俱乐部不存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $exists = Db::name('club_user')->where('id',$id)->find();
        if(!$exists){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '该id不存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $admin = Db::name('club_user')->where('wechatUserId',$this->user['id'])->where('clubId',$clubId)->find();

        if(isset($isManager)){
            if(isset($admin['isCreator']) && $admin['isCreator']==1){
                Db::name('club_user')->where('id',$id)->update(['isManager'=>$isManager]);
            }else{
                exit(json_encode(['code' => 1012,'data'=>'','message' => '权限不足,无法设置管理员','success'=> false],JSON_UNESCAPED_UNICODE));
            }
        }
        if(isset($isDelete)){
            if( (isset($admin['isCreator']) && $admin['isCreator']==1) ||  (isset($admin['isManager']) && $admin['isManager']==1) ){
                Db::name('club_user')->where('id',$id)->where('isCreator',0)->where('isManager',0)->delete();
            }else{
                exit(json_encode(['code' => 1012,'data'=>'','message' => '权限不足,无法移除成员','success'=> false],JSON_UNESCAPED_UNICODE));
            }
        }

        exit(json_encode(['code' => 200, 'data'=>'',
            'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
    }


    //29活动报名
    public function applyActivity()
    {
        $data['activityId'] = input('activityId');
        $data['userName'] = input('userName','');
        $data['userGender'] = input('userGender');
        $data['userPhone'] = input('userPhone ','');
        $data['followManNum'] = input('followManNum','');
        $data['followWomanNum'] = input('followManNum','');
        $data['fee'] = input('fee');

        if(!isset($data['activityId'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,activityId不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        if(!isset($data['fee'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,fee不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $data['wechatUserId'] = $this->user['id'];
        $data['openid'] = $this->user['openid'];
        $data['createTime'] = date('Y-m-d H:i:s');

        $activity = Db::name('activity')->where('id',$data['activityId'])->find();
        if(!$activity){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '该活动不存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        Db::name('activity_user')->insert($data);

        // $clubUser = Db::name('club_user')
        //     ->where('clubId',$data['clubId'])
        //     ->where('wechatUserId',$data['wechatUserId'])
        //     ->find();
        //
        // if($clubUser){
        //     exit(json_encode(['code' => 1012,'data'=>'','message' => '已加入该俱乐部','success'=> false],JSON_UNESCAPED_UNICODE));
        // }

        // Db::name('club_user')->insert($data);


        exit(json_encode(['code' => 200, 'data'=>'',
            'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));

    }


    //退出俱乐部
    public function quitClub()
    {
        $data['clubId'] = input('clubId');
        // $data['userName'] = input('userName','');
        // $data['userGender'] = input('userGender');
        // $data['userPhone'] = input('userPhone ','');
        // $data['userIdCard'] = input('userIdCard','');

        if(!isset($data['clubId'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,clubId不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $club = Db::name('club')->where('clubId',$data['clubId'])->find();
        if(!$club){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '该俱乐部不存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        $clubUser = Db::name('club_user')
            ->where('clubId',$data['clubId'])
            ->where('wechatUserId',$this->user['id'])
            // ->where('status',0)
            ->find();

        if(!$clubUser){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '没有加入俱乐部','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        Db::name('club_user')
            ->where('clubId',$data['clubId'])
            ->where('wechatUserId',$this->user['id'])->delete();


        exit(json_encode(['code' => 200, 'data'=>'',
            'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));

    }

    //获取手机号
    public function getPhone()
    {
        $encryptedData = input('encryptedData');
        $iv = input('iv');


        if(!isset($encryptedData)){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,encryptedData不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $encryptedData = base64_decode($encryptedData);
        $iv = base64_decode($iv);
        $session_key = base64_decode($this->user['session_key']);

        $result=openssl_decrypt( $encryptedData, "AES-128-CBC", $session_key, 1, $iv);
        // dump($result);

        $dataObj=json_decode( $result );
        if( $dataObj  == NULL )
        {
            exit(json_encode(['code' => 1012,'data'=>'','message' => $dataObj,'success'=> false],JSON_UNESCAPED_UNICODE));
        }
        // if( $dataObj->watermark->appid !=  )
        // {
        //     exit(json_encode(['code' => 1012,'data'=>'','message' => $dataObj,'success'=> false],JSON_UNESCAPED_UNICODE));
        // }

        exit(json_encode(['code' => 200, 'data'=>['phone'=>$result],
            'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));

    }


    //37取消报名
    public function withdrawActivity()
    {
        $activityId = input('activityId');

        if(!isset($activityId)){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,activityId不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $activity = Db::name('activity')->where('id',$activityId)->find();
        if(!$activity){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '该活动不存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $cancelDeadline = $activity['activityLiveDate']." ".$activity['cancelDeadline'] ;
        if(date('Y-m-d H:i:s') > $cancelDeadline){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '取消报名已截止,'.$cancelDeadline,'success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $activityUser = Db::name('activity_user')->where('activityId',$activityId)
            ->where('wechatUserId',$this->user['id'])->find();
        if(!$activityUser){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '没有报名','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        $activityUser = Db::name('activity_user')->where('activityId',$activityId)
            ->where('wechatUserId',$this->user['id'])->delete();

        exit(json_encode(['code' => 200, 'data'=>'',
            'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));

    }

}
