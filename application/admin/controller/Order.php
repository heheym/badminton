<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/8/8
 * Time: 17:09
 */

namespace app\admin\controller;

use app\admin\model\Order as OrderModel;
use app\admin\model\Community as CommunityModel;
use app\admin\model\Driver as DriverModel;
use think\Db;

class Order extends Common
{
    public function index()
    {
        $list_rows = 5;
        $order_status = input('order_status');
        $community = input('community');
        $search_name = input('search_name');
        $sldate = input('reservation');
        $export = input('export');


        $map = [];
        if($order_status!=='' && $order_status != null){
            $map['order_status'] = $order_status;
        }
        if($sldate){
            $arr = explode(' - ',$sldate);
            $map['submit_time'] = ['between',[$arr[0],$arr[1]]];
            $this->assign('sldate',$sldate);
        }
        if($community!=='' && $community != null){
            $map['c_id'] = $community;
        }
        //订单编号，用户名,收货人
        if($search_name){
            $map['order_sn|nickname|consignee'] = ['like','%'.$search_name.'%'];
            $this->assign('search_name',$search_name);

        }

        $community = CommunityModel::all();
        $this->assign('community',$community);
        $driver = DriverModel::all();
        $this->assign('driver',$driver);


        $orderModel = new OrderModel();

        $data = $orderModel->alias('o')->field('o.*,c.*,d.name as d_name')->join('community c','o.cid = c.c_id','LEFT')
                ->join('user','o.uid=user.id','LEFT')
                ->join('driver d','o.did=d.id','LEFT')
                ->where($map)->where('o_status',1)->paginate(null,false,['page'=>input('page'),'list_rows'=>1]);

        //订单导出
        if($export){

            $orders = Db::view('order','id,uid,order_sn_submit,consignee,mobile,amount,order_status,submit_time')
                        ->view('user','nickname','user.id=order.uid','LEFT')
                        ->view('order_goods','price,num,price*num as subtotal','order.id=order_goods.oid','LEFT')
                        ->view('goods','id as gid,name','goods.id=order_goods.gid','LEFT')
                        ->view('community','c_name,c_address,c_id','community.c_id=order.cid','LEFT')
                        ->where($map)->where('o_status',1)->select();

            $temp = [];  //总量
            $title = ['id'=>'序号','order_sn_submit'=>'订单号','consignee'=>'收件人','mobile'=>'电话','amount'=>'总金额','order_status'=>'状态','submit_time'=>'下单时间','nickname'=>'用户','price'=>'单价','num'=>'数量','subtotal'=>'小计','name'=>'商品名','c_name'=>'小区名称','c_address'=>'提货地址'];

            $goods = [];  //商品分类
            $goodsTitle = ['gid'=>'商品id','name'=>'商品名','num'=>'数量'];

            $communityTemp=[];  //社区商品分类
            $userTemp = [];    //社区用户商品分类

            foreach($orders as $k => $v){
                //
                foreach($title as $kk=>$vv){
                    if($kk=='order_status'){
                        $array = ['待付款','已完成','待发货','待收货','已取消','待退款','已退款','拒绝退款'];
                        $v[$kk] = $array[$v[$kk]];
                    }
                    if($kk=='order_sn_submit'){
                        $temp[$k][] = $v[$kk]."\t";
                    }else{
                        $temp[$k][] = $v[$kk];
                    }

                }
                //
                if(array_key_exists($v['gid'],$goods) ){
                    $goods[$v['gid']]['数量'] += $v['num'];
                }else{
                    foreach ($goodsTitle as $kkk=>$vvv){
                        $goods[$v['gid']][$vvv] = $v[$kkk];
                    }
                }
                //
                if(isset($communityTemp[$v['c_name']][$v['gid']])){
                    $communityTemp[$v['c_name']][$v['gid']]['num'] += $v['num'];
                }
                else{
                    $communityTemp[$v['c_name']][$v['gid']] = $v;
                }
                //
                if(isset($userTemp[$v['c_name'].'_'.$v['consignee'].'_'.$v['mobile']][$v['gid']])){
                    $userTemp[$v['c_name'].'_'.$v['consignee'].'_'.$v['mobile']][$v['gid']]['num'] += $v['num'];
                }else{
                    $userTemp[$v['c_name'].'_'.$v['consignee'].'_'.$v['mobile']][$v['gid']] = $v;
                }

            }

            include(VENDOR_PATH.'excel\php-excel.php');

            $xls = new \Excel('sheet1'); //构造函数，参数为第一个sheet名称
            $xls->worksheets['sheet1']->addRow($title); //添加一行，数据为1,2,3
            foreach ($temp as $tempValue){
                $xls->worksheets['sheet1']->addRow($tempValue);
            }
            $xls->addsheet('sheet2');//新建一个sheet，参数为sheet名称
            $xls->worksheets['sheet2']->addRow($goodsTitle);//在第二个sheet添加一行
            foreach ($goods as $goodsValue){
                $xls->worksheets['sheet2']->addRow($goodsValue);
            }
            $xls->addsheet('sheet3');//新建一个sheet，参数为sheet名称
            $xls->worksheets['sheet3']->addRow(['社区','数量']);//在第二个sheet添加一行
            foreach ($communityTemp as $k=>$communityTempValue){
                $xls->worksheets['sheet3']->addRow(['','']);
                $xls->worksheets['sheet3']->addRow([$k,'']);
                foreach ($communityTempValue as $g){
                    $xls->worksheets['sheet3']->addRow([$g['name'],$g['num']]);
                }
            }
            $xls->addsheet('sheet4');//新建一个sheet，参数为sheet名称
            $xls->worksheets['sheet4']->addRow(['社区','收件人','电话','商品名','数量']);//在第二个sheet添加一行
            foreach ($userTemp as $kk=>$userTemp1){
                foreach ($userTemp1 as $userTemp2){
                    $xls->worksheets['sheet4']->addRow([
                        $userTemp2['c_name'],$userTemp2['consignee'],
                        $userTemp2['mobile'],$userTemp2['name'],
                        $userTemp2['num']
                    ]);

                }
            }

            $xls->generate('订单导出'.date('YmdH:i:s'));//下载excel，参数为文件名


//            exportToExcel('订单导出'.date('YmdH:i:s').'.csv',$goodsTitle,$goods);
//            exportToExcel('订单导出'.date('YmdH:i:s').'.csv',$title,$temp);
            exit;
        }

        //统计订单
        $summary = $orderModel->field('order_status,count(*) as sum')->group('order_status')->select();
        $this->assign('summary',$summary);

        $subQuery =  Db::table('fox_order')->alias('o')->field('amount')->join('community c','o.cid = c.c_id','LEFT')
                     ->join('user','o.uid=user.id','LEFT')
                     ->where($map)->where('o_status',1)->page(input('page'),$list_rows)->buildSql();
        $amount = Db::table( $subQuery.' o' ) ->sum('amount');

        $sum = $orderModel->alias('o')->join('community c','o.cid = c.c_id','LEFT')
               ->join('user','o.uid=user.id','LEFT')
                ->where($map)->where('o_status',1)->sum('amount');

        $this->assign('amount',$amount);
        $this->assign('sum',$sum);

        $page = $data->render();
        $page=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$page);
        $this->assign('page',$page);
        $this->assign('data',$data);

        if(request()->isAjax()){
            return $this->fetch('ajax_index');
        }
        return $this->fetch();
    }

    public function del()
    {
        $ids = input('ids/a');
        if(empty($ids)){
            return error('请选中需要删除的数据');
        }
        if(is_array($ids)){
            foreach($ids as $k => $v){
                $id[] = $k;
            }
            $where = 'id in('.implode(',',$id).')';
        }else{
            $where = 'id='.$ids;
        }

        $result = Db::name('order')->where($where)->update(['o_status'=>0]);
        if($result){
            return success('删除成功',url('admin/order/index'));
        }
        return error('删除失败');
    }

    public function delOne()
    {
        $ids = input('ids');
        $result = Db::name('order')->where('id',$ids)->update(['status'=>0]);
        if($result){
            return success('删除成功',url('admin/order/index'));
        }
        return error('删除失败');
    }
/*
 * 订单信息
 * */
    public function add()
    {
        $id = input('id/d');
        if(empty($id)){
            return error('参数错误');
        }
        $exists = Db::name('order')->find($id);
        if(!$exists){
            return error('订单不存在');
        }
        if(request()->isPost()){
            $note = input('note/s');
            $result = Db::name('order')->update(['id'=>$id,'note'=>$note]);
            if($result!==false){
                return success('保存成功',url('order/add',['id'=>$id]));
            }
            return error('保存失败',url('order/add',['id'=>$id]));
        }

        $goods = OrderModel::get($id)->goods()->alias('og')
                 ->join('goods','goods.id=og.gid','LEFT')->select();

        $orders = Db::view('order')->view('order_goods','*','order.id=order_goods.oid','LEFT')->view('goods','*','goods.id=order_goods.gid','LEFT')
                    ->view('community','*','community.c_id=order.cid','LEFT')->view('user','*','user.id=order.uid','LEFT')
                    ->where('order.id',$id)->find();


        $this->assign('goods',$goods);
        $this->assign('orders',$orders);

        return $this->fetch();
    }

    public function deliver()
    {
        $mall = Db::name('mall')->find();
        $oid = input('oid/d');
        $driver = input('driver/d');
        $order = OrderModel::get(['id'=>$oid,'order_status'=>2]);
        $order->startTrans();
        $result = $order->save(['did'=>$driver,'order_status'=>3,'deliver_time'=>date('Y-m-d H:i:s',time())]);
        $end_time=date("Y-m-d H:i:s",strtotime($result->deliver_time." + ".$mall['receive']." minute"));  //自动收货时间
        $cron = $order -> cron()->save(['status'=>1,'starttime'=>$order->deliver_time,'endtime'=>$end_time]);
        if($result && $cron){
            $order->commit();
            return success('发货成功',url('order/index'));
        }
        $order->rollback();
        return error('失败或已发货');

    }

    public function batchdeliver()
    {
        $post = input('post.');
        $ids = input('ids/a');
        $driver = input('driver/d');

        if(empty($ids)){
            return error('请至少选择一条');
        }
        if(is_array($ids)){
            foreach($ids as $k => $v){
                $id[] = $k;
            }
            $where = 'id in('.implode(',',$id).')';
        }else{
            $where = 'id='.$ids;
        }
        Db::startTrans();
        $ids = Db::name('order')->where('order_status',2)->where($where)->column('id');
        $result = Db::name('order')->where('order_status',2)->where($where)->update(['did'=>$driver,'order_status'=>3,'deliver_time'=>date('Y-m-d H:i:s',time())]);

        foreach($ids as $v){
            $data[]=
                ['status'=>1,'starttime'=>date('Y-m-d H:i:s',time()),'endtime'=>date("Y-m-d H:i:s",strtotime("+1 day")),'oid'=>$v];
        }
        $cron = Db::name('cron')->insertAll($data);

        if($result && $cron){
            Db::commit();
            return success('发货成功',url('admin/order/index'));
        }
        Db::rollback();
        return error('失败或已发货');

    }

    public function refund()
    {
        $id = input('id/d');
        $exists = Db::name('order')->find($id);
        if(!$exists){
            return error('参数错误');
        }
        $orderModel = new OrderModel();
        $result = $orderModel->refund($id);
        if($result['result_code'] == 'SUCCESS'){
            $refund_result = Db::name('order')->where(['id'=>$id,'order_status'=>5])->update(['order_status'=>6]);
            if($refund_result){
                return success('退款成功',url('order/index'));
            }
        }
        return error('退款失败');
    }

    public function reject()
    {
        $id = input('id/d');
        $exists = Db::name('order')->find($id);
        if(!$exists){
            return error('参数错误');
        }
        $result = Db::name('order')->where(['id'=>$id,'order_status'=>5])->update(['order_status'=>7]);
        if($result){
            return success('操作成功',url('order/index'));
        }
        return error('操作错误');
    }

    public function excel()
    {
        $a = Db::query('select id,consignee,count(*) as count from fox_order  group by consignee having count>1');
        var_dump($a);
    }

}