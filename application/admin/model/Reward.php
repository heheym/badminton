<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/8/24
 * Time: 9:43
 */

namespace app\admin\model;
use think\Model;
use think\Db;

class Reward extends Model
{
    public function getRstatusAttr($value)
    {
        $status = ['待审核','待打款','已打款','已手动打款','已驳回'];
        return  $status[$value];
    }

//    public function getCidAttr($value)
//    {
//        $WxInfo = Db::name('community c')->join('user u','c.uid=u.id','LEFT')->where('c.c_id',$value)->find();
//        return $WxInfo;
//    }

    public function reward($no='',$openid='',$amount='')
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
        $data['desc'] = '提现';
        $data['spbill_create_ip'] = getIP();
        $data['sign'] = sign($data);
        $xml = arrayToXml($data);
        $response = postXmlSSLCurl($xml, $url);
//        var_dump($response);exit;
        //将微信返回的结果xml转成数组
        return xmlstr_to_array($response);
    }


}