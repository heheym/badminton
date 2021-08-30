<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/8/23
 * Time: 15:57
 */

namespace app\admin\controller;
use app\admin\model\Reward as RewardModel;
use think\Db;

class Reward extends Common
{
    public function index()
    {
        $list_rows = 5;
        $rstatus = input('rstatus');
        $search_name = input('search_name');
        $map = [];
        if( $rstatus!=='' && $rstatus != null){
            $map['rstatus'] = $rstatus;
        }
        //姓名，用户昵称
        if($search_name){
            $map['realname|nickname'] = ['like','%'.$search_name.'%'];
            $this->assign('search_name',$search_name);
        }
        $RewardModel = new RewardModel();
        $data = $RewardModel->alias('r')->join('community c','c.c_id=r.cid','LEFT')->join('user u','u.id=c.uid','LEFT')->where($map)->field('r.*,c.*,u.nickname,u.head')->paginate($list_rows);
        $this->assign('data',$data);

        $page = $data->render();
        $this->assign('page',$page);

        if(request()->isAjax()){
            return $this->fetch('ajax_index');
        }
        return $this->fetch();

    }

    //审核
    public function examine()
    {
        $id = input('id/d');
        $action = input('action/d');
        $exists = Db::name('reward')->find($id);
        if(!$exists){
            return error('参数错误');
        }
        if($action==1){
            $result = Db::name('reward')->update(['id'=>$id,'rstatus'=>1]);
            if($result){
                return success('审核完成',url('reward/index'));
            }
            return error('审核失败',url('reward/index'));
        }
        $result = Db::name('reward')->update(['id'=>$id,'rstatus'=>4]);
        if($result){
            return success('驳回成功',url('reward/index'));
        }
        return error('驳回失败',url('reward/index'));
    }

    //打款
    public function reward()
    {
        $id = input('id/d');
        $action = input('action/d');
        $exists = Db::name('reward')->find($id);
        if(!$exists){
            return error('参数错误');
        }
        if($action ===1){
            $reward = Db::name('reward')->where('id',$id)->find();
            $openid = Db::name('reward r')->join('community c','c.c_id=r.cid','LEFT')
                ->join('user u','u.id=c.uid','LEFT')->where('r.id',$id)->value('openid');

            $result = $this -> paid($no=$reward['partner_trade_no'],$openid,$amount=$reward['amount'],$desc='提现');
            if($result['result_code']=='SUCCESS'){
                Db::name('community')->where('c_id',$exists['cid'])->update([
                    'pay_commision'=>['exp','pay_commision-'.$exists['amount']],
                    'cash_commision'=>['exp','cash_commision+'.$exists['amount']]
                ]);
                Db::name('reward')->where('id',$id)->update(['rstatus'=>2]);
                return success('微信打款成功',url('reward/index'));
            }
            return error($result['err_code_des']);
        }
        Db::name('community')->where('c_id',$exists['cid'])->update([
            'pay_commision'=>['exp','pay_commision-'.$exists['amount']],
            'cash_commision'=>['exp','cash_commision+'.$exists['amount']]
        ]);
        Db::name('community')->where('c_id',$exists['cid'])->update();
        $result = Db::name('reward')->where('id',$id)->update(['rstatus'=>3]);
        if($result){
            return success('打款成功',url('reward/index'));
        }
        return error('打款失败',url('reward/index'));
    }

    public function redis()
    {
        $redis = new \Redis();
        $redis -> connect('127.0.0.1',6379);
        $redis -> set('username','xiaobai');
        echo $redis->get('username');
    }


}