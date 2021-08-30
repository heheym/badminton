<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/7/31
 * Time: 9:56
 */

namespace app\admin\controller;

use app\admin\model\Access;
use think\Request;
use think\Db;
use think\Verify;
use think\Session;
use app\admin\model\Admin as AdminModel;

class Admin extends Common
{
    public function login()
    {
        if(session('?admin_id') && session('admin_id')>0){
           $this ->redirect(url('admin/index/index'));
        }

        if(request()->isPost()){
           $vcode = input('vcode');
            $result = $this->validate(
                [
                    'vcode'  => $vcode,
                ],
                [
                    'vcode|验证码'  => 'require|captcha',
                ]);
            if(true !== $result){
                // 验证失败 输出错误信息
                return error($result);
            }

            $name = input('name/s');
            $password = input('password/s');
            $password_r = $password;
            $rememberme = input('rememberme');
            if(!empty($name) && !empty($password)){
                $password = encrypt($password);
                $admin_info = Db::name('admin')->alias('a')->join('user_role','a.id=user_role.uid','LEFT')
                                ->join('role','role.id=user_role.role_id','LEFT')
                                ->field('a.id,a.name,role.name as role_name,role.act_list')
                                ->where(['a.name'=>$name,'password'=>$password])->find();
                if(is_array($admin_info)){
                    session('admin_id',$admin_info['id']);
                    session('admin_name',$admin_info['name']);
                    session('act_list',$admin_info['act_list']);
                    session('role_name',$admin_info['role_name']);
                    if($rememberme){
                        cookie('admin',['name'=>$name,'password'=>$password_r]);
                    }else{
                        cookie('admin',null);
                    }

//                    Db::name('admin')->where("id = ".$admin_info['id'])->save(array('last_login'=>time(),'last_ip'=>  getIP()));
//                    session('last_login_time',$admin_info['last_login']);
//                    session('last_login_ip',$admin_info['last_ip']);
                    adminLog('后台登录');
                    $url = session('from_url') ? session('from_url') : url('Admin/Index/index');
                    return success('登录成功',$url);
                }else{
                    return error('账号密码不正确');
                }
            }else{
                return error('请填写帐号密码');
            }
        }
        if(cookie('admin')){
            $this->assign('cookie',cookie('admin'));
        }
        return $this->fetch();
    }
    /**
     * 退出登陆
     */
    public function logout(){

        Session::clear();
        $this->redirect('/');
    }
    /**
     * 管理员列表
     */
    public function admin_list()
    {
        $search_name=input('search_name');
        $this->assign('search_name',$search_name);
        $map=array();
        if($search_name){
            $map['a.name']= array('like',"%".$search_name."%");
        }
//        $admin_list=Db::name('admin')->where($map)->order('id')->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
        $admin_list=Db::name('admin')->alias('a')->join('user_role ur','a.id = ur.uid','Left')
                    ->join('role r','ur.role_id=r.id','LEFT')
                    ->field('a.id,a.name,a.ip,a.status,ur.role_id,r.name as r_name')->where($map)->order('id')->paginate(2);

        $page = $admin_list->render();

        $this->assign('admin_list',$admin_list);
        $this->assign('page',$page);
        return $this->fetch();
    }
    /**
     * 管理员添加/编辑
     */
    public function admin_add()
    {
        $id = input('id/d');
        if(request()->isPost()){
            $data = input('post.');

            if(!empty($id)){
                $exist = Db::name('admin')->where('id','<>',$id)->where(['name'=>$data['name']])->find();
                if($exist){
                    return error('用户名已存在');
                }
                $rst=AdminModel::edit($data);
                if($rst!==false){
                    return success('管理员修改成功',url('admin/Admin/admin_list'));
                }else{
                    return error('管理员修改失败',url('admin/Admin/admin_list'));
                }

            }

            $exists = Db::name('admin')->where(['name'=>$data['name']])->find();
            if($exists){
                return error('用户名已存在');
            }
            $admin_id=AdminModel::add($admin_username=input('name'),$admin_pwd=$data['password'],$admin_email='',$admin_tel='',$admin_open=1,$admin_realname='',$group_id=input('role_id'));
            if($admin_id){
                return success('管理员添加成功',url('admin/Admin/admin_list'));
            }else{
                return error('管理员添加失败',url('admin/Admin/admin_list'));
            }
        }

        if(!empty($id)) {
            $data = Db::name('admin')->alias(a)->join('user_role ur','a.id = ur.uid','LEFT')->where(['a.id'=>$id])->field('a.id,a.name,ur.role_id')->find();
            if(!empty($data)){
                $this->assign(['data'=>$data]);
            }
        }
        $role=Db::name('role')->select();
        $this->assign('role',$role);
        return $this->fetch();
    }
    /**
     * 管理员删除
     */
    public function admin_del()
    {
        $admin_id=input('id/d');
        if (empty($admin_id)){
            return error('用户ID不存在',url('admin/Admin/admin_list'));
        }

        $rst=Db::name('admin')->where('id',$admin_id)->delete();
        if($rst){
            return success('管理员删除成功',url('admin/Admin/admin_list'));
        }else{
            return error('管理员删除失败',url('admin/Admin/admin_list'));
        }
    }
    /**
     * 管理员开启/禁止
     */
    public function admin_state()
    {
        $id=input('x');
        if (empty($id)){
            $this->error('用户ID不存在',url('admin/Admin/admin_list'));
        }
        $status=Db::name('admin')->where('admin_id',$id)->value('admin_open');//判断当前状态情况
        if($status==1){
            $statedata = array('admin_open'=>0);
            Db::name('admin')->where('admin_id',$id)->setField($statedata);
            $this->success('状态禁止');
        }else{
            $statedata = array('admin_open'=>1);
            Db::name('admin')->where('admin_id',$id)->setField($statedata);
            $this->success('状态开启');
        }
    }

    /**
     * 用户组列表
     */
    public function role_list()
    {
        $role=Db::name('role')->select();
        $this->assign('role',$role);
        return $this->fetch();
    }
    /**
     * 用户组添加/编辑
     */
    public function role_add()
    {
        $id = input('id/d');

        if (request()->isPost()){
            $sldata=array(
                'name'=>input('name'),
                'status'=>input('status',1),
                'created_time'=> date("Y-m-d H:i:s"),
            );
            $exists = Db::name('role') -> where(['name'=>input('name')])->find();
            if($exists){
                return error('用户组已存在');
            }
            if($id){
                $sldata['id'] = $id;
                $rst = Db::name('role') -> update($sldata);
            }else {
                $rst = Db::name('role')->insert($sldata);
            }
            if($rst!==false){
                return success('用户组保存成功',url('admin/Admin/role_list'));
            }else{
                return error('用户组保存失败',url('admin/Admin/role_list'));
            }
        }

        if(!empty($id)){
            $data = Db::name('role')->find($id);
            $this->assign(['data'=>$data]);
        }
        return $this->fetch();
    }
    /**
     * 用户组删除操作
     */
    public function role_del()
    {
        $rst=Db::name('role')->delete(input('id'));
        if($rst!==false){
            return success('用户组删除成功',url('admin/Admin/role_list'));
        }else{
            return error('用户组删除失败',url('admin/Admin/role_list'));
        }
    }
    /**
     * 权限配置
     */
    public function access_list()
    {
        $role_id = input('id/d');
        $detail = array();
        if($role_id){
            $detail = Db::name('role')->where("id",$role_id)->find();
            $detail['act_list'] = explode(',', $detail['act_list']);
            $this->assign('detail',$detail);
        }
        $right = Db::name('access')->order('id')->select();
        foreach ($right as $val){
            if(!empty($detail)){
                $val['enable'] = in_array($val['id'], $detail['act_list']);
            }
//            $exarray = ['system','content','member','marketing','tools','count'];
//            if(in_array($val['group'],$exarray)) continue;
            $modules[$val['group']][] = $val;
        }
        //权限组
        /*
        $group = array('system'=>'系统设置','content'=>'内容管理','goods'=>'商品中心','member'=>'会员中心',
            'order'=>'订单中心','marketing'=>'营销推广','tools'=>'插件工具','count'=>'统计报表'
        );
        */
        $group = array('admin'=>'管理员管理','community'=>'社区管理','driver'=>'司机管理','category'=>'分类管理',
            'goods'=>'商品管理','order'=>'订单管理','user'=>'会员管理','reward'=>'提现管理','ad'=>'广告管理'
        );
        $this->assign('group',$group);
        $this->assign('modules',$modules);
        return $this->fetch();
    }
    /*
     * 角色权限保存
     * */
    public function access_add(){
        $data = input('post.');
        $res['name'] = $data['name'];
        $res['act_list'] = is_array($data['right']) ? implode(',', $data['right']) : '';
        if(empty($data['role_id'])){
            $r = Db::name('role')->insert($res);
        }else{
            $r = Db::name('role')->where('id', $data['role_id'])->update($res);
        }
        if($r !== false){
//            adminLog('管理角色');
            return success("操作成功!",url('Admin/Admin/role_list'));
        }else{
            return error("操作失败!",url('Admin/Admin/role_list'));
        }
    }


}
