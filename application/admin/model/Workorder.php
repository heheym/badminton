<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/10/23
 * Time: 9:56
 */

namespace app\admin\model;


use think\Model;
use think\Db;

class Workorder extends Model
{
    protected $autoWriteTimestamp = "timestamp";
    public function getCidAttr($value)
    {
        return Db::name('community')->where('c_id',$value)->value('c_name');
    }

    public function getStatusAttr($value)
    {
        $array =['待审核','已同意','已拒绝'];
        return($array[$value]);
    }

    public function image()
    {
        return $this->hasMany('Workima','wid','id');
    }
}