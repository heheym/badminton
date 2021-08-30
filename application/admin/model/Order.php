<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/8/8
 * Time: 17:09
 */

namespace app\admin\model;
use think\Db;

use think\Model;

class Order extends Model
{
    public function getOrderStatusAttr($value)
    {
        $status = ['待付款','已完成','待发货','待收货','已取消','待退款','已退款','已拒绝退款'];
        return $status[$value];
    }

    public function getUidAttr($value)
    {
        return Db::name('user')->where('id',$value)->value('nickname');
    }

    public function getCidAttr($value)
    {
        return Db::name('community')->where('c_id',$value)->value('communiter');
    }

    public function goods()
    {
        return $this -> hasMany('OrderGoods','oid','id');
    }

    public function goods2()
    {
        return $this->belongsToMany('Goods','order_goods','oid','id');
    }

    public function cron()
    {
        return $this->hasOne('Cron','oid','id');
    }

    public function refund($id)
    {
        $order = Db::name('order')->find($id);
        $url = 'https://api.mch.weixin.qq.com/secapi/pay/refund';
        $notify_url = config('wx.notify_url');
        $nonce_str = getRandChar(32);
        $data['appid'] = config('wx.appid');
        $data['mch_id'] = config('wx.mch_id');
        $data['nonce_str'] = $nonce_str;
        $data['out_trade_no'] = $order['order_sn_submit'];
        $data['out_refund_no'] = $data['out_trade_no'];
        $data['total_fee'] = $order['amount']*100;
        $data['refund_fee'] = $data['total_fee'];
        $data['sign'] = sign($data);
        $xml = arrayToXml($data);
        $response = postXmlSSLCurl($xml, $url);
//        var_dump($response);exit;
        //将微信返回的结果xml转成数组
        return xmlstr_to_array($response);
    }

}