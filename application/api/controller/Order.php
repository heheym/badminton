<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/8/27
 * Time: 16:20
 */

namespace app\api\controller;

use think\Db;
use think\Controller;
use app\api\controller\Redis2 as Redis2;

class Order extends Controller
{

    public function  index()
    {
        $redis = new Redis2('127.0.0.1','6379','',0);
        $order_sn   = 'SN'.time().'T'.rand(10000000,99999999);

        $use_mysql = 1;         //是否使用数据库，1使用，2不使用
        if($use_mysql == 1){
            /*
             *   //数据表
             *   CREATE TABLE `order` (
             *      `ordersn` varchar(255) NOT NULL DEFAULT '',
             *      `status` varchar(255) NOT NULL DEFAULT '',
             *      `createtime` varchar(255) NOT NULL DEFAULT '',
             *      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
             *       PRIMARY KEY (`id`)
             *   ) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;
            */

            $data       = ['order_sn'=>$order_sn,'order_status'=>0,'submit_time'=>date('Y-m-d H:i:s',time())];
            Db::name('order')->insert($data);
        }

        $list = [$order_sn,$use_mysql];
        $key = implode(':',$list);

        $redis->setex($key,10,'redis延迟任务');      //3秒后回调



        $test_del = false;      //测试删除缓存后是否会有过期回调。结果：没有回调
        if($test_del == true){
            //sleep(1);
            $redis->delete($order_sn);
        }

        echo $order_sn;



        /*
         *   测试其他key会不会有回调，结果：有回调
         *   $k = 'test';
         *   $redis2->set($k,'100');
         *   $redis2->expire($k,10);
         *
        */
    }

    public function subscribe()
    {
        ini_set('default_socket_timeout', -1);  //不超时
        $redis_db = 0;
        $redis = new Redis2('127.0.0.1','6379','',$redis_db);
// 解决Redis客户端订阅时候超时情况
        $redis->setOption();
//当key过期的时候就看到通知，订阅的key __keyevent@<db>__:expired 这个格式是固定的，db代表的是数据库的编号，由于订阅开启之后这个库的所有key过期时间都会被推送过来，所以最好单独使用一个数据库来进行隔离
        $redis->psubscribe(array("__keyevent@0__:expired"),function($redis, $pattern, $channel, $msg) {

//            echo PHP_EOL;
//            echo "Pattern: $pattern\n";
//            echo "Channel: $channel\n";
//            echo "Payload: $msg\n\n";
            $list = explode(':', $msg);

            $order_sn = isset($list[0]) ? $list[0] : '0';
            $use_mysql = isset($list[1]) ? $list[1] : '0';

            if ($use_mysql == 1) {
                $find = Db::name('order')->where('order_sn', $order_sn)->find();

                if (isset($find['order_status']) && $find['order_status'] == 0) {
                    $result = Db::name('order')->where('id', $find['id'])->update(['order_status'=>4]);
                    if ($result) {
                        echo 'gengxinchenggong';
                    }
                    else{
                        echo 'gengxinshibai';
                    }
                }
            }
        });
// 回调函数,这里写处理逻辑





//或者
        /*$redis->psubscribe(array('__keyevent@'.$redis_db.'__:expired'), function ($redis, $pattern, $channel, $msg){
            echo PHP_EOL;
            echo "Pattern: $pattern\n";
            echo "Channel: $channel\n";
            echo "Payload: $msg\n\n";
            //................
        });*/
    }




}