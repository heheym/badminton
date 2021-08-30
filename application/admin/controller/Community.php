<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/8/4
 * Time: 15:32
 */

namespace app\admin\controller ;
use think\Db;

Class Community extends Common
{
    public function index()
    {
        $search_name=input('search_name');
        $this->assign('search_name',$search_name);
        $map=array();
        if($search_name){
            $map['c.c_name']= array('like',"%".$search_name."%");
        }


        $data=Db::name('community')->alias('c')->join('user','user.id=c.uid','LEFT')->join('community co','co.c_id=c.referee','LEFT')->where('c.status',1)->field('c.c_id,c.c_name,c.communiter,c.c_address,c.c_phone,c.lng,c.lat,c.c_reg_time,co.communiter as referee,nickname')->where($map)->paginate(10);

        $page = $data->render();

        $this->assign('data',$data);
        $this->assign('page',$page);

        return $this->fetch();
    }

    public function add()
    {
        $id = input('c_id');
        if(request()->isAjax()) {
            $data = input('post.');
            if(empty($data['c_id'])){
                unset($data['c_id']);
                $result = Db::name('community')->insertGetId($data);
                if($result){
                    return success('保存成功',url('admin/community/index'));
                }
                return error('保存失败');
            }
            $result = Db::name('community')->update($data);
            if($result!==false){
                return success('保存成功',url('admin/community/index'));
            }
            return error('保存失败');
        }
        if(!empty($id)){
            $data = Db::name('community')->alias('c')->join('user','user.id=c.uid','LEFT')
                    ->where(['c.status'=>'1','c.c_id'=>$id])
                    ->find();
            $data2 = Db::name('community')->alias('c')->join('user','user.id=c.uid','LEFT')
                    ->where(['c.status'=>'1','c.c_id'=>$data['referee']])
                    ->find();

            $this->assign('data',$data);
            if($data2){
                $this->assign('data2',$data2);
            }
        }

        return $this->fetch();
    }

    public function del()
    {
        $id = input('c_id/d');
        $exist = Db::name('community')->find($id);
        if(!$exist){
            return error('参数错误',url('admin/community/index'));
        }
        $result= Db::name('community')->where('c_id',$id)->update(['status'=>0]);
        if($result){
            return success('删除成功',url('admin/community/index'));
        }
    }

    public function search_user()
    {
        if(request()->isAjax()){
            $search['nickname'] = input('search/s');
            $user = Db::name('user')->where('nickname','like','%'.$search['nickname'].'%')->select();
            if($user){
                $html = '';
                foreach($user as $k =>$v){
                    $html.=<<<EOF
                            <div class="col-sm-1 " style="margin: 10px;" >
                                    <div class="thumbnail" style="width:100px;height:100px;">
                                            <img src="{$v['head']}"  onclick="change(this)" uid="{$v['id']}">
                                        <div class="caption">
                                            <p>{$v['nickname']}</p>                                   
                                        </div>
                                    </div>
                             </div>
EOF;
                }
                exit($html);
            }

            echo ('没有数据');
        }
    }

    public function search_referee()
    {
        if(request()->isAjax()){
            $community = input('referee/s');
            $user = Db::name('community')->alias(c)->join('user','user.id=c.uid','INNER')->where('communiter','like','%'.$community.'%')->select();
            if($user){
                $html = '';
                foreach($user as $k =>$v){
                    $html.=<<<EOF
                            <div class="col-sm-1 " style="margin: 10px;" >
                                    <div class="thumbnail" style="width:100px;height:100px;">
                                            <img src="{$v['head']}"  onclick="chang(this)" uid="{$v['c_id']}">
                                        <div class="caption">
                                            <p>{$v['communiter']}</p>                                   
                                        </div>
                                    </div>
                             </div>
EOF;
                }
                exit($html);
            }

            echo ('没有数据');
        }
    }

}