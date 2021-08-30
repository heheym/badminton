<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/9/15
 * Time: 16:49
 */

namespace app\admin\controller;

use think\Db;

class Test
{
    public function index()
    {
        $usernum = 0;    //插入的用户数
        $communitynum = 0; //插入的社区数
        $ordernum = 50;  //插入的订单数
        $goodsnum = 0;     //插入的商品数

        //用户
        Db::startTrans();

        for($i=0;$i<$usernum;$i++){
            $user = [
                'nickname'=>'微信昵称'.getRandChar(5)
            ];
            Db::name('user')->insert($user);
        }
        $user = Db::name('user')->column('id');
        $uid = $user[array_rand($user)];


        //社区
        for($i=0;$i<$communitynum;$i++){
            while($exists = Db::name('community')->where('uid',$uid)->find()){
                $uid = $user[array_rand($user)];
            }

            $community = [
                'c_name'=>'社区名'.getRandChar(5),'uid'=>$uid
            ];
            Db::name('community')->insert($community);
        }
        $community = Db::name('community')->column('c_id');
        $cid = $community[array_rand($community)];


        //商品
        $goods = Db::name('goods')->column('id');

        //订单
        for($i=0;$i<$ordernum;$i++)
        {
            while(true){
                $order_sn = date('YmdHis').rand(1000,9999); // 订单编号
                $order_sn_count = Db::name('order')->where("order_sn = ".$order_sn)->count();
                if($order_sn_count == 0)
                    break;
            }

            $order = [
                'order_sn'=>$order_sn,'order_sn_submit'=>$order_sn,'order_status'=>2,'uid'=>$user[array_rand($user)],
                'cid'=>$community[array_rand($community)]
            ];

            $oid = Db::name('order')->insertGetId($order);

            //插入商品
            for($ii=0;$ii<$goodsnum;$ii++){
                $random = rand(1,20);               //商品数量
                $gid = $goods[array_rand($goods)];     //商品id
                $order_goods['oid'] = $oid; //订单ID
                $order_goods['gid'] = $gid; //商品ID
                $order_goods['num'] = $random; //购买数量
                $order_goods['price'] = Db::name('goods')->where('id',$gid)->value('price'); //价格
                Db::name('order_goods')->insert($order_goods);

                $amount = $order_goods['price'] * $order_goods['num'];
                Db::name('order')->where('id',$oid)->setInc('amount',$amount);
            }

        }

        Db::commit();


        $order = Db::name('order')->order('cid desc')->select();
        foreach($order as $k=>$v){
            $amount = Db::name('order_goods')->where('oid',$v['id'])->sum('num*price');
            $sum = Db::name('order_goods')->where('oid',$v['id'])->sum('num');
            echo '订单id:'.$v['id'].'&nbsp;&nbsp;&nbsp;&nbsp;';
            echo '社区id:'.$v['cid'].'&nbsp;&nbsp;&nbsp;&nbsp;';
            echo '订单表金额为:'.$v['amount'].'&nbsp;&nbsp;&nbsp;&nbsp;';
            echo '商品数量:'.$sum.'&nbsp;&nbsp;&nbsp;&nbsp;';
            echo '订单商品表中金额为:'.$amount.'<br />';
        }

    }

}