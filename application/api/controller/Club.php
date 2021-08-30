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

class Club extends Common
{
    //创建俱乐部，上传俱乐部头像，填写俱乐部名称、选择地址、电话、公告
    public function addClubApply()
    {
        $data['head'] = input('head');
        $data['name'] = input('name');
        $address = input('address');
        $data['phone'] = input('phone');
        $data['notice'] = input('notice', '');
        $data['wechatUserId'] = $this->user['id'];
        $data['openid'] = $this->user['openid'];
        $data['createTime'] = date("Y-m-d H:i:s");
        $lagitude = input('lagitude');

        if (!isset($data['head'])) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,head不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        if (!isset($data['name'])) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,name不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }
        if (!isset($address)) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,address不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }
        if (!isset($data['phone'])) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,phone不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        $exists = Db::name('club')->where('name', $data['name'])->find();
        if ($exists) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '俱乐部名称已存在', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        $address = explode(',', $address);
        $lagitude = explode(',', $lagitude);

        $data['province'] = $address[0];
        $data['city'] = $address[1];
        $data['area'] = $address[2];

        $data['longitude'] = $lagitude[0];
        $data['latitude'] = $lagitude[1];

        do {
            $data['clubId'] = sprintf("%06d", mt_rand(0, 999999));
            $exists = Db::name('club')->where('clubId', $data['clubId'])->find();
        } while ($exists);

        $id = Db::name('club')->insert($data);
        Db::name('club_user')->insert(['clubId' => $data['clubId'], 'wechatUserId' => $data['wechatUserId'], 'openid' => $data['openid'], 'createTime' => $data['createTime'], 'isCreator' => 1]);

        exit(json_encode(['code' => 200, 'data' => '', 'message' => '请求成功', 'success' => true], JSON_UNESCAPED_UNICODE));
    }

    //获取俱乐部人员列表
    public function getClubUsers()
    {
        $page = input('page', '');
        $rows = input('rows', 10);
        $clubId = input('clubId');

        if (!isset($clubId)) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,clubId不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }
        $club = Db::name('club')->where('clubId', $clubId)->field(["*","concat(province,',',city,',',area)  as address"])->find();
        if (!$club) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,俱乐部不存在', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        $user = Db::name('club_user')->where('clubId', $clubId)->where('wechatUserid', $this->user['id'])->find();


        $num = Db::name('club')->where('fox_club.clubId',$clubId)
            ->join('fox_club_user','fox_club_user.clubId=fox_club.clubId','left')
            ->join('fox_user','fox_user.id=fox_club_user.wechatUserId')
            ->join('fox_activity','fox_activity.clubId=fox_club.clubId','left')
            ->field(["count(fox_club_user.id) as userNum","fox_activity.id as actNum"])
            ->find();

        $data = Db::name('club')->where('fox_club.clubId',$clubId)
                ->join('fox_club_user','fox_club_user.clubId=fox_club.clubId','left')
                ->join('fox_user','fox_user.id=fox_club_user.wechatUserId','left')
                ->join('fox_activity','fox_activity.clubId=fox_club.clubId','left')
                ->join('fox_activity_user','fox_activity_user.activityId=fox_activity.id and fox_activity_user.wechatUserId=fox_club_user.wechatUserId','left')
            ->group('fox_club_user.clubId,fox_club_user.wechatUserId')

            ->field(['fox_club.clubId','fox_club.name as clubName','fox_club.wechatUserId as clubWechatUserId',
        'fox_club_user.id','fox_user.gender','fox_user.avatarurl','fox_club_user.isCreator','fox_club_user.isManager','fox_club_user.wechatUserId','fox_user.nickname as wechatUserName','count(fox_activity_user.wechatUserId) as signActNum'])
        ->paginate($rows)->toArray();



        if(!$user){
            $user['isJoin'] = 0;
            $user['isCreator'] = 0;
            $user['isManager'] = 0;
        }else{
            $user['isJoin'] = 1;
        }

        $arr = [
            'code' => 200,
            'data' =>[
                'total' => $data['total'],
                'isCreator' => $user['isCreator'],
                'isManager' => $user['isManager'],
                'isJoin' => $user['isJoin'],
                'clubId' => $club['clubId'],
                'name' => $club['name'],
                'head' => $club['head'],
                'notice' => $club['notice'],
                'address' => $club['address'],
                'userNum' => $num['userNum'],
                'actNum' => $num['actNum'],
                'rows'=>$data['data']
            ],
            'message'=>'请求成功',
            'success'=>true
        ];

        exit(json_encode($arr,JSON_UNESCAPED_UNICODE));
    }

    //获取俱乐部
    public function getClub()
    {
        $page = input('page', '');
        $rows = input('rows', 10);
        $clubId = input('clubId');
        $lagitude = input('lagitude');


        // if (!isset($clubId)) {
        //     exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,clubId不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        // }

        if(isset($clubId)){
            $exists = Db::name('club')->where('clubId', $clubId)->find();
            if (!$exists) {
                exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,俱乐部不存在', 'success' => false], JSON_UNESCAPED_UNICODE));
            }
            $data = Db::name('club')->where('fox_club.clubId',$clubId)
                ->join('fox_club_user','fox_club_user.clubId=fox_club.clubId','left')
                ->join('fox_activity','fox_activity.clubId=fox_club.clubId','left')
                ->field(["fox_club.head",
                                "fox_club.name",
                                "fox_club.phone",
                                "concat(fox_club.province,',',fox_club.city,',',fox_club.area)  as address",
                                "fox_club.notice",
                                "fox_club.createTime",
                                "fox_club.updateTime",
                                "fox_club.wechatUserId",
                                "fox_club.openid",
                                "fox_club.clubId",
                    "count(fox_club_user.id) as userNum","fox_activity.id as actNum"
            ])->paginate($rows)->toArray();
        }elseif(isset($lagitude)){

            $lagitude = explode(',',$lagitude);
            $lon = $lagitude[0];
            $lat = $lagitude[1];

            /*
             *  经度：117.215637   纬度：39.1373367*/
              $sql = "select * from(
SELECT id,longitude,latitude,
ROUND(6378.138*2*ASIN(SQRT(POW(SIN(($lat*PI()/180-latitude*PI()/180)/2),2)+COS($lat*PI()/180)*COS(latitude*PI()/180)*POW(SIN(($lon*PI()/180-longitude*PI()/180)/2),2)))*1000) AS juli
FROM fox_club) as tmp_table_name
where juli < 10000
order by juli";

            $subQuery = Db::table('fox_club')
                ->field("*,ROUND(6378.138*2*ASIN(SQRT(POW(SIN(($lat*PI()/180-latitude*PI()/180)/2),2)+COS($lat*PI()/180)*COS(latitude*PI()/180)*POW(SIN(($lon*PI()/180-longitude*PI()/180)/2),2)))*1000) AS juli")
                ->buildSql();

            $data = Db::table($subQuery.' a')
                ->join('fox_club_user','fox_club_user.clubId=a.clubId','left')
                ->join('fox_activity','fox_activity.clubId=a.clubId','left')
                ->group('a.clubId')
                ->field([
                    "a.juli",
                    "a.head",
                    "a.name",
                    "a.phone",
                    "concat(a.province,',',a.city,',',a.area)  as address",
                    "a.notice",
                    "a.createTime",
                    "a.updateTime",
                    "a.wechatUserId",
                    "a.openid",
                    "a.clubId",
                    "count(fox_club_user.id) as userNum","count(fox_activity.id) as actNum"
                ])
                ->where('a.juli','<','100000')
                ->order('juli')
                ->paginate($rows)->toArray();



            // $data = Db::table('fox_club')->alias('a')
            //     ->join('fox_club_user','fox_club_user.clubId=a.clubId','left')
            //     ->join('fox_activity','fox_activity.clubId=a.clubId','left')
            //     ->field([
            //         "ROUND(6378.138*2*ASIN(SQRT(POW(SIN(($lat*PI()/180-a.latitude*PI()/180)/2),2)+COS($lat*PI()/180)*COS(a.latitude*PI()/180)*POW(SIN(($lon*PI()/180-a.longitude*PI()/180)/2),2)))*1000) AS juli",
            //         "a.head",
            //         "a.name",
            //         "a.phone",
            //         "concat(a.province,',',a.city,',',a.area)  as address",
            //         "a.notice",
            //         "a.createTime",
            //         "a.updateTime",
            //         "a.wechatUserId",
            //         "a.openid",
            //         "a.clubId",
            //         "count(fox_club_user.id) as userNum","fox_activity.id as actNum"
            //     ])
            //     ->group('a.clubId')
            //     // ->having('abc<10000')
            //     ->paginate($rows)->toArray();

        }
        if($data['total']==0){
            $arr = [
                'code' => 200,
                'data' =>[
                    'total' => $data['total'],
                    'rows'=>null
                ],
                'message'=>'请求成功',
                'success'=>true
            ];
        }else{
            foreach($data['data'] as $k=>&$v){
                $userNum = Db::name('club_user')->where('clubId',$v['clubId'])->count();
                $v['userNum'] = $userNum;
                $actNum = Db::name('activity')->where('clubId',$v['clubId'])->count();
                $v['actNum'] = $actNum;
            }
            $arr = [
                'code' => 200,
                'data' =>[
                    'total' => $data['total'],
                    'rows'=>$data['data']
                ],
                'message'=>'请求成功',
                'success'=>true
            ];
        }

        exit(json_encode($arr,JSON_UNESCAPED_UNICODE));
    }


    //更新俱乐部
    public function updateClubInfo()
    {
        $clubId = input('clubId');
        if(input('head')){
            $data['head'] = input('head');
        }
        if(input('name')){
            $data['name'] = input('name');
        }
        if(input('address')){
            $address = input('address');
            $address = explode(',', $address);
            $data['province'] = $address[0];
            $data['city'] = $address[1];
            $data['area'] = $address[2];
        }
        if(input('phone')){
            $data['phone'] = input('phone');
        }
        if(input('notice')){
            $data['notice'] = input('notice', '');
        }

        $data['updateTime'] = date("Y-m-d H:i:s");

        if (!isset($clubId)) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,clubId不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        $exists = Db::name('club')->where('clubId', $clubId)->find();
        if (!$exists) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '俱乐部不存在', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        $admin = Db::name('club_user')->where('wechatUserId',$this->user['id'])->where('clubId',$clubId)->find();
        if(!$admin){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '权限不足,无法修改','success'=> false],JSON_UNESCAPED_UNICODE));
        }
        if( (isset($admin['isCreator']) && $admin['isCreator']==0) &&  (isset($admin['isManager']) && $admin['isManager']==0) ){
            exit(json_encode(['code' => 1012,'data'=>'','message' => '权限不足,无法修改','success'=> false],JSON_UNESCAPED_UNICODE));
        }

        $id = Db::name('club')->where('clubId',$clubId)->update($data);

        exit(json_encode(['code' => 200, 'data' => '', 'message' => '请求成功', 'success' => true], JSON_UNESCAPED_UNICODE));

    }

    //出勤表
    public function getAttendance()
    {
        $page = input('page', '');
        $rows  = input('rows', 10);

        $clubId = input('clubId');
        $attendanceDate = input('attendanceDate',date("Y-m-d"));
        if (empty($clubId)) {
            exit(json_encode(['code' => 1012, 'data' => '', 'message' => '参数出错,clubId不能为空', 'success' => false], JSON_UNESCAPED_UNICODE));
        }

        $data = Db::name('activity')
            ->join('fox_activity_user','fox_activity.id=fox_activity_user.activityId')
            ->join('fox_user','fox_user.id=fox_activity_user.wechatUserId')
            ->where('fox_activity.clubId',$clubId)
            ->where('fox_activity.activityLiveDate',$attendanceDate)
            ->field(["fox_user.nickname","fox_activity_user.createTime","fox_activity_user.fee","10 as balance"])
            ->paginate($rows)->toArray();


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

            exit(json_encode(['code' => 200, 'data'=>['total'=>$data['total'],'rows'=>$data['data']],
                'message'=>'请求成功','success'=>true],JSON_UNESCAPED_UNICODE));
        }


    }



}
