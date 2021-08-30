<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/10/30
 * Time: 14:53
 */

namespace app\admin\controller;
use think\Db;
use app\admin\model\Payment as PaymentModel;

class Payment extends Common
{
    public function index()
    {
        $search_name = input('search_name');
        $page = input('page');
        $map = [];
        if(!empty($search_name)){
            $map['c_name'] = ['like','%'.$search_name.'%'];
            $this->assign('search_name',$search_name);
        }
        $data = PaymentModel::alias('p')->join('community c','c.c_id=p.cid','LEFT')->order('id desc')->where($map)->paginate(null,false,['page'=>$page,'list_rows'=>10]);
        $page = $data->render();
        $page=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$page);
        $this->assign('data',$data);
        $this->assign('page',$page);

        if(request()->isAjax()){
            return $this->fetch('ajax_index');
        }
        return $this->fetch();
    }
}