<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/10/22
 * Time: 17:37
 */

namespace app\admin\controller;
use think\Db;
use app\admin\model\Workorder as WorkModel;

class Workorder extends Common
{
    public function index()
    {

        $data = WorkModel::all();

        foreach ($data as $v){
            $img = Db::name('workima')->where('wid',$v->id)->column('img');
            $v->img = $img;
        }

        $this->assign('data',$data);
        return $this->fetch();
    }

    public function edit()
    {
        $id = input('id');
        $amount = input('amount');
        $action = input('action');

        if($action==1){
            Db::name('workorder')->where('id',$id)->update(['status'=>2]);
            return success('操作成功',url('workorder/index'));
        }
        $workorder = Db::name('workorder')->where('id',$id)->find();
        $openid = Db::name('workorder w')->join('community c','c.c_id=w.cid','LEFT')
                    ->join('user u','u.id=c.uid')->where('w.id',$id)->value('openid');
        $result = Db::name('community')->where('c_id',$workorder['cid'])->update([
            'total_commision'  => ['exp','total_commision+'.$amount],
            'present_commision' => ['exp','present_commision+'.$amount],
        ]);;
        Db::name('workorder')->where('id',$id)->update([
            'amount'=>$amount,
            'status' => 1
        ]);
        $present_commision = Db::name('community')->where('c_id',$workorder['cid'])->value('present_commision');
        //保存佣金明细
        Db::name('payment')->insert([
            'cid'=>$workorder['cid'],
            'balance' => $amount,
            'leave' => $present_commision,
            'detail' => '工单打款',
            'create_time' => date('Y-m-d H:i:s',time())
        ]);
        if($result){
            return success('打款成功',url('workorder/index'));
        }
    }

}