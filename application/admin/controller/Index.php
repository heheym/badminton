<?php
namespace app\admin\controller;
use think\Controller;
use think\Db;

class Index extends Common
{
    public function index(){
        return view();
    }

    public function content(){
        // $data['all'] = Db::name('order')->count();
        //
        // $beginToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d'),date('Y')));
        // $endToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1);
        // $map['submit_time'] = ['between',[$beginToday,$endToday]];
        // $data['today'] = Db::name('order')->where($map)->count();
        //
        // $beginThisweek=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')-date('w')+1,date('Y')));
        // $endThisweek=date('Y-m-d H:i:s',mktime(23,59,59,date('m'),date('d')-date('w')+7,date('Y')));
        // $map['submit_time'] = ['between',[$beginThisweek,$endThisweek]];
        // $data['week'] = Db::name('order')->where($map)->count();
        //
        // $beginThismonth=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),1,date('Y')));
        // $endThismonth=date('Y-m-d H:i:s',mktime(23,59,59,date('m'),date('t'),date('Y')));
        // $map['submit_time'] = ['between',[$beginThismonth,$endThismonth]];
        // $data['month'] = Db::name('order')->where($map)->count();
        //
        // $data['0'] = Db::name('order')->where('order_status',0)->count();
        // $data['1'] = Db::name('order')->where('order_status',1)->count();
        // $data['2'] = Db::name('order')->where('order_status',2)->count();
        // $data['3'] = Db::name('order')->where('order_status',3)->count();
        //
        // $beginToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d'),date('Y')));
        // $endToday=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1);
        // $map['submit_time'] = ['between',[$beginToday,$endToday]];
        // $map['order_status'] = 1 ;
        // $data['today_income'] = Db::name('order')->where($map)->sum('amount');
        //
        // $beginThismonth=date('Y-m-d H:i:s',mktime(0,0,0,date('m'),1,date('Y')));
        // $endThismonth=date('Y-m-d H:i:s',mktime(23,59,59,date('m'),date('t'),date('Y')));
        // $map['submit_time'] = ['between',[$beginThismonth,$endThismonth]];
        // $map['order_status'] = 1 ;
        // $data['month_income'] = Db::name('order')->where($map)->sum('amount');
        //
        //
        // $data['total_income'] = Db::name('order')->where('order_status',1)->sum('amount');
        //
        // $data['refund'] = Db::name('order')->where('order_status',6)->sum('amount');
        //
        // $this->assign('data',$data);
        // return view();
    }
}
