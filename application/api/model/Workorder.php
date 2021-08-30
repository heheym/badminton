<?php
/**
 * Created by PhpStorm.
 * User: xiaobaidaren
 * Date: 2018/10/22
 * Time: 14:51
 */
namespace app\api\model ;
use think\Model;

class Workorder extends Model
{
    protected $autoWriteTimestamp = 'timestamp';
    protected $updateTime = false;

    public function image(){
        return $this->hasMany('Workima','wid','id');
    }

}