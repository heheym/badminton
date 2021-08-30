<?php
namespace app\admin\controller;
use think\Controller;
use think\Request;
use think\Db;

class Common extends Controller
{
    /*
      * 初始化操作
      */
    public function _initialize()
    {
        define('CONTROLLER_NAME',Request::instance()->controller());
        define('ACTION_NAME',Request::instance()->action());
        //过滤不需要登陆的行为
        if(in_array(ACTION_NAME,array('login','logout','vertify')) || in_array(CONTROLLER_NAME,array('Ueditor','Uploadify'))){
            //return;
        }else{
            if(session('admin_id') > 0 ){
                $this->check_priv();
            }else{
                $this->redirect('/');
            }
        }
        $this->assign('session',session(''));
    }

    public function check_priv()
    {
        $ctl = CONTROLLER_NAME;
        $act = ACTION_NAME;
        $act_list = session('act_list');
        //无需验证的操作
        $uneed_check = array('login','logout','vertifyHandle','vertify','imageUp','upload','login_task');
        if($ctl == 'Index' || $act_list == 'all' ){
            //后台首页控制器无需验证,超级管理员无需验证
            return true;
        }elseif(request()->isAjax() || in_array($act,$uneed_check)){
            //所有ajax请求不需要验证权限
            return true;
        }else{
            $right = Db::name('access')->where("id", "in", $act_list)->column('right');
            foreach ($right as $val){
                $role_right .= $val.',';
            }
            $role_right = explode(',', $role_right);

            //检查是否拥有此操作权限
            if(!in_array($ctl.'_'.$act, $role_right ) && !in_array($ctl, $role_right) && session('admin_id')!==1){
                    $this->error('您没有权限,请联系超级管理员分配权限',url('admin/index/index'));
            }
        }
    }

    // 单图片或文件异步上传
    public function upload_image(){
        $file = request()->file(input('name'));
        $info = $file->move(ROOT_PATH . 'public/uploads');
        if($info){
            $fileName = str_replace('\\', '/', $info->getSaveName());
            return json_encode($fileName); //文件名

        }
    }

    // 多图片或文件异步上传
    public function upload_images(){
        $file = request()->file('file');
        $info = $file->move(ROOT_PATH . 'public/uploads');
        if($info){
            $fileName = str_replace('\\', '/', $info->getSaveName());
            return json_encode($fileName); //文件名
        }
    }

    // 通用删除功能
    public function delete($id = 0){
        // 获取当前数据表名（控制器名）
        $table = request()->controller();
        if(Db::name($table)->where('id', $id)->delete()){
            return success('删除成功',url('index'));
        }else{
            return error('删除失败');
        }
    }

    public function paid($no='',$openid='',$amount='',$desc='')
    {
//        $order = Db::name('order')->find($id);
        $url = 'https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers';
        $notify_url = config('wx.notify_url');
        $nonce_str = getRandChar(32);
        $data['mch_appid'] = config('wx.appid');
        $data['mchid'] = config('wx.mch_id');
        $data['nonce_str'] = $nonce_str;
        $data['partner_trade_no'] = $no;
        $data['openid'] = $openid;
        $data['check_name'] = 'NO_CHECK';
//        $data['re_user_name'] = '';
        $data['amount'] = $amount;
        $data['desc'] = $desc;
        $data['spbill_create_ip'] = getIP();
        $data['sign'] = sign($data);
        $xml = arrayToXml($data);
        $response = postXmlSSLCurl($xml, $url);
//        var_dump($response);exit;
        //将微信返回的结果xml转成数组
        return xmlstr_to_array($response);
    }

}
