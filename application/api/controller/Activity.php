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

class Activity extends Common
{
    //发布活动,修改为活动模板
    public function addActivity()
    {
        $data['name'] = input('name');
        $address= input('address');
        $data['street']  = input('street');
        $lagitude = input('lagitude');
        $data['phone'] = input('phone');
        $data['notice'] = input('notice');
        $data['num'] = input('num');
        $data['feeType'] = input('feeType');
        $data['feeMan'] = input('feeMan');
        $data['feeWoman'] = input('feeWoman');
        $data['activityType'] = input('activityType');
        $data['activityDate'] = input('activityDate');
        $data['activityStartTime'] = input('activityStartTime');
        $data['activityEndTime'] = input('activityEndTime');
        $data['regDeadline'] = input('regDeadline');
        $data['cancelDeadline'] = input('cancelDeadline');
        $data['follow'] = input('follow');
        $data['open'] = input('open');
        $data['head'] = input('head');
        $data['clubId'] = input('clubId');

        $data['createTime'] = date("Y-m-d H:i:s");
        $data['openid'] = $this->user['openid'];
        $data['wechatUserId'] = $this->user['id'];


        if(!isset($data['head'])){
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,head不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }
        if(!isset($data['name'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,name不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        if(!isset($address)){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,address不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        if(!isset($data['street'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,street不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        if(!isset($lagitude)){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,lagitude不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        if(!isset($data['phone'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,phone不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        if(!isset($data['clubId'])){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '参数出错,clubId不能为空','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $exists = Db::name('activity')->where('name',$data['name'])->find();
        if($exists){
            exit(json_encode(['code' => 1012,'data'=>'', 'message' => '活动标题已存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        // $address= explode(',',$address);
        $lagitude = explode(',', $lagitude);

        $club = Db::name('club')->where('clubId',$data['clubId'])->find();
        if(!$club){
            exit(json_encode(['code' => 1012,'data'=>'', 'message' => '俱乐部不存在','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $data['province'] = $club['province'];
        $data['city'] = $club['city'];
        $data['area'] = $club['area'];

        $data['longitude'] = $lagitude[0];
        $data['latitude'] = $lagitude[1];

        $id = Db::name('activity_template')->insertGetId($data);
        $data['templateId'] = $id;

        $date = explode(',',$data['activityDate']);

        try{
            $activityTemplate = Db::name('activity_template')->select();
            foreach($activityTemplate as $k=>$v){
                if($v['activityType']==1){
                    $activityDate = explode(',',$v['activityDate']);
                    $dayArr = get_week();
                    foreach($dayArr as $dayk=>$dayv){
                        if(in_array($dayv['week'],$activityDate)){
                            $exists = Db::name('activity')->where('templateId',$v['id'])
                                ->where('activityLiveDate',$dayv['date'])->find();
                            if($exists){
                                continue;
                            }
                            $v['activityLiveDate'] = $dayv['date'];
                            if($v['activityLiveDate']." ".$v['regDeadline'] < date("Y-m-d H:i:s") ){
                                continue;
                            }
                            $v['templateId'] = $v['id'];
                            $insertData = $v;
                            unset($insertData['id']);
                            Db::name('activity')->insert($insertData);
                        }
                    }
                }else{
                    $exists = Db::name('activity')->where('templateId',$v['id'])
                        ->find();
                    if($exists){
                        continue;
                    }
                    $v['templateId'] = $v['id'];
                    $v['activityLiveDate'] = $v['activityDate'];
                    $insertData = $v;
                    unset($insertData['id']);
                    Db::name('activity')->insert($insertData);
                }
            }
        }catch (\Exception $e){
            exit(json_encode(['code' => 1012, 'data'=>'','message' => $e->getMessage(),'success'=> false],JSON_UNESCAPED_UNICODE));
        }

        exit(json_encode(['code' => 200, 'data'=>'','message' => '请求成功','success'=> true],JSON_UNESCAPED_UNICODE));
    }

    //获取俱乐部活动
    public function getActivity()
    {
        $page = input('page', '');
        $rows = input('rows', 10);
        $lagitude = input('lagitude');
        $city = input('city');
        $activityLiveDate = input('activityLiveDate');
        $clubId = input('clubId');
        $activityId = input('activityId');

        // if (!isset($lagitude)) {
        //     exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,lagitude不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        // }

        if(!empty($clubId)){
            $where['fox_club.clubId'] = $clubId;
        }
        if(!empty($activityLiveDate)){
            $where['fox_activity.activityLiveDate'] = $activityLiveDate;
        }
        if(!empty($city)){
            $where['fox_activity.city'] = $city;
        }
        if(!empty($lagitude)){
            $lagitude = explode(',',$lagitude);
            $lon = $lagitude[0];
            $lat = $lagitude[1];
            if(!empty($clubId)){
                $where1['fox_club.clubId'] = $clubId;
            }
            if(!empty($activityLiveDate)){
                $where1['a.activityLiveDate'] = $activityLiveDate;
            }
            if(!empty($city)){
                $where1['a.city'] = $city;
            }
            $subQuery = Db::table('fox_activity')
                ->field("*,ROUND(6378.138*2*ASIN(SQRT(POW(SIN(($lat*PI()/180-latitude*PI()/180)/2),2)+COS($lat*PI()/180)*COS(latitude*PI()/180)*POW(SIN(($lon*PI()/180-longitude*PI()/180)/2),2)))*1000) AS juli")
                ->buildSql();

            $data = Db::table($subQuery.'a')
                ->join('fox_club','fox_club.clubId=a.clubId','left')
                ->field([
                    "a.id as activityId","a.name","a.notice","a.head","concat(a.province,',',a.city,',',a.area) as adress","a.street","concat(a.longitude,',',a.latitude) as lagitude","a.phone","a.feeType","a.feeMan","a.feeWoman","a.activityType","a.activityDate","a.activityLiveDate","a.activityStartTime","a.activityEndTime","a.regDeadline","a.cancelDeadline","a.follow","fox_club.name as clubName","fox_club.head as clubHead","concat(fox_club.province,',',fox_club.city,',',fox_club.area) as clubAdress","fox_club.clubId","a.num"
                ])
                ->where('a.juli','<','10000')
                ->where($where1)
                ->order('juli')
                ->paginate($rows)->toArray();
        }else{
            $data = Db::name('activity')->where($where)
                ->join('fox_club','fox_club.clubId=fox_activity.clubId','left')
                ->field(["fox_activity.id as activityId","fox_activity.name","fox_activity.notice","fox_activity.head","concat(fox_activity.province,',',fox_activity.city,',',fox_activity.area) as adress","fox_activity.street","concat(fox_activity.longitude,',',fox_activity.latitude) as lagitude","fox_activity.phone","fox_activity.feeType","fox_activity.feeMan","fox_activity.feeWoman","fox_activity.activityType","fox_activity.activityDate","fox_activity.activityLiveDate","fox_activity.activityStartTime","fox_activity.activityEndTime","fox_activity.regDeadline","fox_activity.cancelDeadline","fox_activity.follow","fox_club.name as clubName","fox_club.head as clubHead","concat(fox_club.province,',',fox_club.city,',',fox_club.area) as clubAdress","fox_club.clubId","fox_activity.num"])
                ->paginate($rows)->toArray();
        }

        foreach($data['data'] as $k=>&$v){
            if(!empty($activityLiveDate)){
                if($v['activityLiveDate']." ".$v['regDeadline'] < date('Y-m-d H:i:s')){
                    $data['total']--;
                    unset($data['data'][$k]);
                    continue;
                }
            }


            $activityUser = Db::name('activity_user')->where('activityId',$v['activityId'])
                ->join('fox_user','fox_user.id=fox_activity_user.wechatUserId','left')
                ->field(['fox_activity_user.*','fox_user.avatarurl','fox_user.userHead'])
                ->select();
            $v['signUserNum'] = 0;
            foreach($activityUser as $k1=>$v1){
                $v['signUserNum'] += 1+$v1['followManNum']+$v1['followWomanNum'];
            }
            $v['signUser'] = $activityUser;
            // $activityUser = Db::name('activity_user')->where('activityId',$v['activityId'])->paginate(10)->toArray();
            // $v['signUserNum'] = $activityUser['total']+$activityUser['followManNum']+$activityUser['followWomanNum'];
            // $v['signUser'] = $activityUser['data'];

            $v['regDeadline'] = $v['activityLiveDate']." ".$v['regDeadline'];
            $cancelDeadline = $v['activityLiveDate']." ".$v['cancelDeadline'];

            $v['activityDate'] = explode(',',$v['activityDate']);

            $arr = ['1'=>'一','2'=>'二',3=>'三',4=>'四',5=>'五',6=>'六',7=>'七'];
            $day = date("w" ,strtotime($v['activityLiveDate']));
            $v['activityDate'] = "周".$arr[$day];
            $v['cancelDeadline'] = floor((strtotime($cancelDeadline)-time())/3600);

        }

        $arr = [
            'total'=>$data['total'],
            'rows'=>$data['data'],
            'message'=>'请求成功',
            'success'=>true];

        exit(json_encode(['code' => 200, 'data'=>$arr],JSON_UNESCAPED_UNICODE));

    }

    //获取俱乐部活动详情
    public function getActivityInfo()
    {

        $activityId = input('activityId');

        if (!isset($activityId)) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,activityId不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

            $data = Db::name('activity')->where(['fox_activity.id'=>$activityId])
                ->join('fox_club','fox_club.clubId=fox_activity.clubId','left')
                ->field(["fox_activity.id as activityId","fox_activity.name","fox_activity.notice","fox_activity.head","concat(fox_activity.province,',',fox_activity.city,',',fox_activity.area) as adress","fox_activity.street","concat(fox_activity.longitude,',',fox_activity.latitude) as lagitude","fox_activity.phone","fox_activity.feeType","fox_activity.feeMan","fox_activity.feeWoman","fox_activity.activityType","fox_activity.activityDate","fox_activity.activityLiveDate","fox_activity.activityStartTime","fox_activity.activityEndTime","fox_activity.regDeadline","fox_activity.cancelDeadline","fox_activity.follow","fox_club.name as clubName","fox_club.head as clubHead","concat(fox_club.province,',',fox_club.city,',',fox_club.area) as clubAdress","fox_club.clubId","fox_activity.num"])
                ->paginate(10)->toArray();

        // dump();


        foreach($data['data'] as $k=>&$v){
            $activityUser = Db::name('activity_user')->where('activityId',$v['activityId'])
                ->join('fox_user','fox_user.id=fox_activity_user.wechatUserId','left')
                ->field(['fox_activity_user.*','fox_user.avatarurl','fox_user.userHead'])
                ->select();
            $v['signUserNum'] = 0;
            foreach($activityUser as $k1=>$v1){
                $v['signUserNum'] += 1+$v1['followManNum']+$v1['followWomanNum'];
            }
            $v['signUser'] = $activityUser;

            $isSign = Db::name('activity_user')->where('activityId',$v['activityId'])
                ->where('wechatUserid',$this->user['id'])->find();  //是否报名


            $v['regDeadline'] = $v['activityLiveDate']." ".$v['regDeadline'];
            $cancelDeadline = $v['activityLiveDate']." ".$v['cancelDeadline'];
            $v['activityDate'] = explode(',',$v['activityDate']);
            $arr = ['1'=>'一','2'=>'二',3=>'三',4=>'四',5=>'五',6=>'六',7=>'七'];
            $day = date("w" ,strtotime($v['activityLiveDate']));
            $v['activityDate'] = "周".$arr[$day];
            $v['cancelDeadline'] = floor((strtotime($cancelDeadline)-time())/3600);

        }

        $arr = [
            'total'=>$data['total'],
            'isSign' => !empty($isSign)?1:0,
            'rows'=>$data['data'],
            'message'=>'请求成功',
            'success'=>true];

        exit(json_encode(['code' => 200, 'data'=>$arr],JSON_UNESCAPED_UNICODE));

    }


    //获取活动报名名单
    public function getSignList()
    {
        $page = input('page', '');
        $rows  = input('rows', 10);

        $activityId = input('activityId');

        if (empty($activityId)) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,activityId不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        $data = Db::name('activity')
            ->join('fox_activity_user','fox_activity.id=fox_activity_user.activityId')
            ->join('fox_user','fox_user.id=fox_activity_user.wechatUserId')
            ->where('fox_activity.id',$activityId)
            ->field(["fox_user.userHead","fox_user.avatarurl","fox_activity_user.userName","fox_user.nickname","fox_activity_user.createTime","fox_activity_user.userGender",
                "fox_activity_user.fee","fox_activity_user.followManNum","fox_activity_user.followWomanNum"])
            ->paginate($rows)->toArray();


        $num = Db::name('activity')
            ->join('fox_activity_user','fox_activity.id=fox_activity_user.activityId')
            ->join('fox_user','fox_user.id=fox_activity_user.wechatUserId')
            ->where('fox_activity.id',$activityId)
            ->field(["sum(case when fox_activity_user.userGender='1' then 1 else 0 end ) 男生人数,sum(case when fox_activity_user.userGender=2 then 1 else 0 end ) 女生人数","sum(followManNum) as totalFollowManNum","sum(followWomanNum) as totalFollowWomanNum"])
            ->find();

        $totalManNum = $num['男生人数'] + $num['totalFollowManNum'];
        $totalWomanNum = $num['女生人数'] + $num['totalFollowManNum'];


        if($data['total']==0){
            exit(json_encode(['code' => 200, 'data'=>['total'=>$data['total'],'rows'=>null],
                'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
        }else{
            // foreach($data['data'] as $k=>&$v){
            //     $userNum = Db::name('club_user')->where('clubId',$v['id'])->count();
            //     $v['userNum'] = $userNum;
            //     $actNum = Db::name('activity')->where('clubId',$v['id'])->count();
            //     $v['actNum'] = $actNum;
            // }

            exit(json_encode(['code' => 200,
                'data'=>[
                    'total'=>$data['total'],
                    'totalManNum' => $totalManNum,
                    'totalWomanNum' => $totalWomanNum,
                'rows'=>$data['data']],
                'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
        }


    }



}
