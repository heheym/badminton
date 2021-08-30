<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/10/24
 * Time: 10:50
 */

namespace app\api\controller;


use think\Model;

class Mall extends Model
{
    public function index()
    {

       exit(json_encode(['code'=>200,'msg'=>['time'=>time()]]));

    }
}