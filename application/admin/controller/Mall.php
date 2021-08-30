<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/9/18
 * Time: 16:25
 */

namespace app\admin\controller;
use think\Db;

class Mall extends Common
{
    public function index()
    {

        if(request()->isPost()){
            $id = input('id/d');
            $post = input('post.');

            if(!preg_match('/^[1-9][0-9]*$/',$post['overtime']) || !preg_match('/^[1-9][0-9]*$/',$post['receive'])){
                return error('时间必须是正整数');
            }
            if(!preg_match('/^[1-9][0-9]*$/',$post['percent'])){
                return error('佣金必须是正整数');
            }
            if(!$id){
                unset($post['id']);
                $result = Db::name('mall')->insert($post);
            }else{
                $result = Db::name('mall')->update($post);
            }

            if($result !==false){
                return success('提交成功',url('mall/index'));
            }
        }
        $data = Db::name('mall')->find();
        $this->assign('data',$data);

        return $this->fetch();
    }
}