<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/11/5
 * Time: 14:12
 */

namespace app\admin\model;
use think\Db;
use think\Model;

class Payment extends Model
{
    protected $autoWriteTimestamp = "timestamp";
    protected $updateTime = false;
    public function getCidAttr($value)
    {
        return Db::name('community')->where('c_id',$value)->value('c_name');
    }
}