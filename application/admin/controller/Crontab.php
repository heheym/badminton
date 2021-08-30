<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/8/29
 * Time: 15:42
 */

namespace app\admin\controller;
use think\Db;

class Crontab
{
    public function index()
    {
        $time = date('Y-m-d H:i:s',time());

        $mall = Db::name('mall')->find();

        Db::startTrans();
        try{
            $subQuery = Db::name('cron')
                ->field('id,status,oid,endtime')
                ->where('endtime','<',$time)
                ->buildSql();
            //库存回复
            $store = Db::name('order o')->join([$subQuery=>'c'],'o.id=c.oid')
                ->join('order_goods og','og.oid=o.id')
                ->where('c.status',0)->where('o.order_status',0)
                -> field('sum(num) as num,gid as id')->group('gid')->select();
            foreach ($store as $kk=>$vv){
                Db::name('goods')->where('id',$vv['id'])->update([
                    'store'  => ['exp','store+'.$v['num']],
                    'sales'  => ['exp','sales-'.$v['num']]
                ]);
            }

            //取消订单
            Db::name('order o')->join([$subQuery=>'c'],'o.id=c.oid')
                ->where('c.status',0)->where('o.order_status',0)
                ->update(['o.order_status'=>4]);


            //更新佣金
            $data = Db::name('order o')->join([$subQuery=>'c'],'o.id=c.oid')
                ->where('c.status',1)->where('o.order_status',3)
                ->field('sum(amount) as sum,cid as id')->group('cid')->select();

            foreach($data as $k=>$v){
                $sum = $v['sum']*$mall['percent']/100;
                Db::name('community')->where('c_id',$v['id'])->update(['total_commision'=>['exp','total_commision+'.$sum],
                    'present_commision'=>['exp','present_commision+'.$sum ] ]);
                $present_commision = Db::name('community')->where('c_id',$v['id'])->value('present_commision');
                //保存佣金明细
                Db::name('payment')->insert([
                    'cid'=>$v['id'],
                    'balance' => $sum,
                    'leave' => $present_commision,
                    'detail' => '自动确认收货',
                    'create_time' => date('Y-m-d H:i:s',time())
                ]);
            }

            //自动收货
            Db::name('order o')->join([$subQuery=>'c'],'o.id=c.oid')->where('c.status',1)->where('o.order_status',3)->update(['o.order_status'=>1]);


            //删除定时
            Db::name('order o')->join([$subQuery=>'c'],'o.id=c.oid')->where('c.status',1)->where('o.order_status',3)->update(['o.order_status'=>1]);


            Db::name('cron')->where('endtime','<',$time)->delete();
            echo '定时成功';
            Db::commit();
        }catch (\Exception $e){
            echo '定时失败';
            var_dump($e);
            Db::rollback();
        }
    }
}