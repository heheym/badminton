<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/9/8
 * Time: 9:39
 */

namespace app\api\controller;
use app\api\model\Workorder;
use think\Db;


class Community extends Common
{
    public function index()
    {
        if(!$this->checkToken()){
            exit(json_encode(['code'=>400,'msg'=>'token出错']));
        }
            $id = input('id');
            $map = [];
            $map['cid'] = $id;   //社区id
            $map['order_status'] = ['between',[1,3]]; //只统计付款且不退款的
            $data = Db::name('community')->alias('c')->join('user u','u.id=c.uid','LEFT')
                    ->field('c.*,u.head')->find($id);

            //今日订单总额
            $beginToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d'),date('Y')));
            $endToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1);
            $map['submit_time'] = ['between',[$beginToday,$endToday]];
            $data['today'] = Db::name('order')->where($map)->sum('amount');


            //本周订单总额
            $beginThisweek=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')-date('w')+1,date('Y')));
            $endThisweek=date('Y-m-d H:i:s',mktime(23,59,59,date('m'),date('d')-date('w')+7,date('Y')));
            $map['submit_time'] = ['between',[$beginThisweek,$endThisweek]];
            $data['week'] = Db::name('order')->where($map)->sum('amount');

            //本月订单总额
            $beginThismonth=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),1,date('Y')));
            $endThismonth=date('Y-m-d H:i:s',mktime(23,59,59,date('m'),date('t'),date('Y')));
            $map['submit_time'] = ['between',[$beginThismonth,$endThismonth]];
            $data['month'] = Db::name('order')->where($map)->sum('amount');

            //总订单总额
            $data['all'] = Db::name('order')->where($map)->sum('amount');

            exit(json_encode(['code'=>200,'msg'=>$data]));

    }

    public function count()
    {
        if(!$this->checkToken()){
            exit(json_encode(['code'=>400,'msg'=>'token出错']));
        }

        $status = input('status/d');  //今日，昨日。。。
        $id = input('id/d');
        $page = input('page/d',1);   //页数
        $length = 5;  //每页显示数

        $map['o.cid'] = $id;
        $map['order_status'] = ['between',[1,3]];

        //今日
        if($status == 1){
            $beginToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d'),date('Y')));
            $endToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1);
            $map['submit_time'] = ['between',[$beginToday,$endToday]];

        }
        //昨日
        if($status == 2){
            $beginYesterday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')-1,date('Y')));
            $endYesterday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d'),date('Y'))-1);
            $map['submit_time'] = ['between',[$beginYesterday,$endYesterday]];
        }
        //前日
        if($status == 3){
            $beginEve=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')-2,date('Y')));
            $endEve=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')-1,date('Y'))-1);
            $map['submit_time'] = ['between',[$beginEve,$endEve]];
        }


        $total = Db::name('order')->alias('o')->join('order_goods og','o.id=og.oid','LEFT')
                 ->field('sum(num*price) as total_amount,sum(num) as total_sum')->where($map)->find();

        $goods = Db::name('order')->alias('o')->join('order_goods og','o.id=og.oid','LEFT')
                 ->join('goods g','g.id=og.gid','LEFT')
                 ->field('g.id,g.name,sum(num) as sum')->where($map)->group('g.id')->select();

        $goods_user = Db::name('order')->alias('o')->join('order_goods og','o.id=og.oid','LEFT')
                    ->join('goods g','g.id=og.gid','LEFT')
                    ->join('user u','u.id=o.uid','LEFT')
                    ->where($map)->group('g.id,u.id')
                    ->field('g.id,g.name,sum(num) as num,u.nickname,u.id as uid')->select();

        $data = [];
        foreach($goods as $k=>$v){
            $data[$v['id']]['name'] = $v['name'];
            $data[$v['id']]['sum'] = $v['sum'];
        }
        foreach($goods_user as $kk=> $vv){
            $data[$vv['id']]['user'][] = $vv;
        }
        $data = array_slice($data,($page-1)*$length,$length,true);

        $user = Db::name('order')->alias('o')->join('order_goods og','o.id=og.oid','LEFT')
                    ->join('goods g','g.id=og.gid','LEFT')
                    ->join('user u','u.id=o.uid','LEFT')
                    ->field('u.id,u.nickname,sum(num) as sum')->where($map)->group('u.id')->select();

        $user_goods = Db::name('order')->alias('o')->join('order_goods og','o.id=og.oid','LEFT')
                        ->join('goods g','g.id=og.gid','LEFT')
                        ->join('user u','u.id=o.uid','LEFT')
                        ->where($map)->group('u.id,g.id')
                        ->field('u.id,u.nickname,g.name,sum(num) as num,g.id as gid')->select();

        $userInfo =[];
        foreach($user as $k=>$v){
            $userInfo[$v['id']]['nickname'] = $v['nickname'];
            $userInfo[$v['id']]['sum'] = $v['sum'];
        }
        foreach($user_goods as $kk=> $vv){
            $userInfo[$vv['id']]['goods'][] = $vv;
        }
        $userInfo = array_slice($userInfo,($page-1)*$length,$length,true);

        exit(json_encode(['code'=>200,'msg'=>['total'=>$total,'goods'=>$data,'userInfo'=>$userInfo]]));
    }

    //我的佣金/团长信息
//    public function commission()
//    {
//        if(!$this->checkToken()){
//            exit(json_encode(['code'=>400,'msg'=>'token出错']));
//        }
//        $id = input('id/d');  //社区id
//        $community = Db::name('community')->where('c_id',$id)->find();
//        if(!$community){
//            exit(json_encode(['code'=>400,'msg'=>'参数错误']));
//        }
//        exit(json_encode(['code'=>200,'msg'=>$community]));
//    }

    //申请提现
    public function reward()
    {
        if(!$this->checkToken()){
            exit(json_encode(['code'=>400,'msg'=>'token出错']));
        }

        $data = [
            'cid'=>input('cid/d'),
            'amount'=>intval(input('amount','')*100), //提现佣金
            'realname' =>input('realname'), //用户名
            'wxacount' =>input('wxacount') //微信账号
        ];
        $limit = Db::name('community')->where('c_id',$data['cid'])->value('present_commision')*100;
//halt($data);

        $validateResult=$this->validate($data,[
            ['cid','require','团长id不存在'],
            ['amount','require|between:100,'.$limit,'金额必须|金额错误'],
            ['realname','require','姓名必须'],
            ['wxacount','require','账号必须']
        ]);

        if($validateResult !==true){
            // 验证失败 输出错误信息
            exit(json_encode(['code'=>400,'msg'=>$validateResult]));
        }

        Db::startTrans();
        //更新团长提现姓名，账号信息
        $updateCom = Db::name('community')->where('c_id',$data['cid'])->update(['realname'=>$data['realname'],'wxacount'=>$data['wxacount']]);
        if($updateCom ===false){
            Db::rollback();
            exit(json_encode(['code'=>400,'msg'=>'更新团长提现失败']));
        }
        //插入提现表
        unset($data['realname'],$data['wxacount']);
        $data['partner_trade_no'] = get_order_sn();
        $data['amount'] = $data['amount']/100;
        $insertRew = Db::name('reward')->insertGetId($data);
        if(!$insertRew){
            Db::rollback();
            exit(json_encode(['code'=>400,'msg'=>'提现失败1']));
        }
        //更新团长佣金
        $updateResult = Db::name('community')->where('c_id',$data['cid'])
                        ->update([
                            'present_commision'=>['exp','present_commision-'.$data['amount']],
                            'pay_commision'=>['exp','pay_commision+'.$data['amount']]
                        ]);
        $present_commision = Db::name('community')->where('c_id',$data['cid'])->value('present_commision');
        //保存佣金明细
        Db::name('payment')->insert([
            'cid'=>input('cid/d'),
            'balance' => '-'.$data['amount'],
            'leave' => $present_commision,
            'detail' => '申请提现',
            'create_time' => date('Y-m-d H:i:s',time())
        ]);
        if(!$updateResult){
            Db::rollback();
            exit(json_encode(['code'=>400,'msg'=>'提现失败2']));
        }
        Db::commit();
        exit(json_encode(['code'=>200,'msg'=>'提现成功']));

    }

    public function reward_detail()
    {
        if(!$this->checkToken()){
            exit(json_encode(['code'=>400,'msg'=>'token出错']));
        }

        $post = input('');
        $rstatus = $post['status'];

        $config = ['page'=>$post['page'], 'list_rows'=>15];
        $map['cid'] = $post['cid'];

        if($rstatus !==5){
            $map['rstatus'] = $rstatus == 2 ? ['between',[2,3]]:$rstatus;
        }

        $data = Db::name('reward')->where($map)->paginate(null,false,$config);
        exit(json_encode(['code'=>200,'msg'=>$data]));

    }

    public function  workorder()
    {
        if(!$this->checkToken()){
            exit(json_encode(['code'=>400,'msg'=>'token出错']));
        }

        $cid = input('cid');
        $ordersn = input('ordersn');
        $des = input('des');
        $image = input('image');
        $amount = input('amount');
        $image =explode(',',$image) ;

        foreach ($image as $v){
            $imageArray[] = ['img'=>$v];
        }
        $workorder = new Workorder();
        $data = [
            'cid'=>$cid,
            'ordersn' => $ordersn,
            'des' => $des,
            'amount' => $amount,
            'partner_trade_no' => get_order_sn()
        ];
        $workorder->save($data);

        $result = $workorder->image()->saveAll($imageArray);
        if(!empty($result)){
            exit(json_encode(['code'=>200,'msg'=>'提交成功']));
        }else{
            exit(json_encode(['code'=>200,'msg'=>'提交失败']));
        }
    }

    public function workindex()
    {
        if(!$this->checkToken()){
            exit(json_encode(['code'=>400,'msg'=>'token出错']));
        }
        $map['cid'] = input('cid');
        $status = input('status');
        $page =input('page');
        if($status!==''){
            $map['status'] = $status;
        }
        $data = Db::name('workorder')->where($map)->order('id desc')
                ->paginate(null,false,['page'=>$page,'list_rows'=>16])
                ->each(function($item, $key){
                    $img = Db::name('workima')->where('wid',$item['id'])->column('img');
                    $item['img'] = $img;
                    return $item;
                });

        exit(json_encode(['code'=>200,'msg'=>$data]));
    }

}