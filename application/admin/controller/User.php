<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/8/8
 * Time: 17:09
 */

namespace app\admin\controller;

use app\admin\model\User as UserModel;
use think\Db;

class User extends Common
{
    public function index()
    {
        $search_name=input('search_name');
        $this->assign('search_name',$search_name);
        $map=array();
        if($search_name){
            $map['nickname']= array('like',"%".$search_name."%");
        }
        $data = Db::name('user')->where($map)->paginate(10);
        $page = $data->render();
        $this->assign('data',$data);
        $this->assign('page',$page);
        return $this->fetch();
    }


}