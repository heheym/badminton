<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/7/31
 * Time: 17:10
 */

namespace app\admin\model;
use think\Model;
use think\Db;

class Admin extends Model
{


    /**
     * 增加管理员
     */
    public static function add($admin_username,$admin_pwd,$admin_email='',$admin_tel='',$admin_open=0,$admin_realname='',$group_id=1)
    {
        $admin_pwd_salt=$admin_pwd_salt?:getRandChar(10);
        $sldata=array(
            'name'=>$admin_username,
//            'admin_pwd_salt' => $admin_pwd_salt,
            'password'=>encrypt($admin_pwd),
//            'admin_email'=>$admin_email,
//            'admin_tel'=>$admin_tel,
//            'admin_open'=>$admin_open,
//            'admin_realname'=>$admin_realname,
            'ip'=>request()->ip(),
            'created_time'=>date('Y-m-d H:i:s'),
//            'updated_time'=>time(),
        );
        $admin=self::create($sldata);
        if($admin){
            //添加管理组
            $admin_id=$admin['id'];
            $accdata=array(
                'uid'=>$admin_id,
                'role_id'=>$group_id,
            );
            Db::name('user_role')->insert($accdata);
            //添加会员
//            $member_id=MemberList::add($admin_username,$admin_pwd_salt,$admin_pwd,1,$admin_realname,$admin_email,$admin_tel,1,1);
            //修改admin对应member_id
//            if($member_id) self::update(['admin_id' =>$admin_id, 'member_id' =>$member_id]);
            return $admin_id;
        }else{
            return 0;
        }
    }
    /**
     * 修改管理员
     * @param array
     * @return bool
     */
    public static function edit($data)
    {
        $admin=self::get($data['id'])->toArray();
        $admin['name']=$data['name'];
//        $admin['admin_email']=$data['admin_email'];
//        $admin['admin_tel']=$data['admin_tel'];
//        $admin['admin_realname']=$data['admin_realname'];
//        $admin['admin_open']=$data['admin_open'];
        if($data['password']){
            $admin['password']=encrypt($data['password']);
//            $admin['admin_changepwd']=time();
        }
        $rst=self::where('id',$data['id'])->update($admin);
        if($rst!==false){
            $access=Db::name('user_role')->where('uid',$data['id'])->find();
            if($access){
                //修改
                if($access['role_id']!=$data['role_id']){
                    Db::name('user_role')->where('uid',$data['id'])->setField('role_id',$data['role_id']);
                }
            }else{
                //增加
                $access['uid']=$data['id'];
                $access['role_id']=$data['role_id'];
                Db::name('user_role')->insert($access);
            }
            return true;
        }else{
            return false;
        }
    }


}