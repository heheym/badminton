<?php
/**
 * Created by PhpStorm.
 * User: ma
 * Date: 2018/8/11
 * Time: 17:45
 */

namespace app\admin\model;


use think\Model;

class OrderGoods extends Model
{
    public function goods()
    {
        return $this->belongsToMany('goods','gid','id');
    }
}