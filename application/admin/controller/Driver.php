<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/8/11
 * Time: 10:05
 */

namespace app\admin\controller;
use app\admin\model\Driver as DriverModel;
use think\Request;


class Driver extends Common
{
    public function index(){
        $search_name = input('search_name');
        $map = array();
        if($search_name){
            $map['name'] = $search_name;
            $this->assign('search_name',$search_name);
        }
        $data = DriverModel::where($map)->where('status',1)->paginate(10);
        $page = $data->render();
        $this->assign('page',$page);
        $this->assign('data',$data);
        return $this->fetch();
    }

    public function add()
    {
        $id = input('id/d');
        if(Request::instance()->isPost()){
            $post = input('post.');
            if($id){
                $exists = DriverModel::get($id);
                if($exists){
                    $result = $exists->save($post);
                    if($result!==false){
                        return success('保存成功');
                    }
                    return error('保存失败');
                }
                return error('参数错误');
            }
            $result = DriverModel::create($post);
            if($result){
                return success('添加成功');
            }
            return error('添加失败');
        }
        if($id){
            $data = DriverModel::get($id);
            $this->assign('data',$data);
        }
        return $this->fetch();
    }

    public function del()
    {
        $id = input('id/d');
        $exists = DriverModel::get($id);
        if($exists!==false){
            $result = $exists->save(['status'=>0]);
            if($result){
                return success('删除成功',url('index'));
            }
            return　error('删除失败');
        }
        return error('参数错误');
    }
}