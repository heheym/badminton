<?php
use think\Route;
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

//input一直无法获取参数，因为加了/
// Route::get('/api/club/common/openid','/api/Login/getUser'); // 定义POST请求路由规则
// Route::any('/api/club/common/uploadUserInfo','/api/User/register');// 定义POST请求路由规则

Route::get('api/club/common/openid','api/Login/getUser'); //获取openid,注册登录
Route::any('api/club/common/uploadUserInfo','api/User/register'); //上传用户信息接口
Route::any('api/club/common/addClubApply','api/Club/addClubApply'); // 创建俱乐部
Route::any('api/club/common/getOwnClubApplys','api/User/getOwnClubApplys'); // 获取创建俱乐部申请记录
Route::any('api/club/common/getOwnClubs','api/User/getOwnClubs'); // 获取创建俱乐部列表
Route::any('api/club/common/applyClub','api/User/applyClub'); // 申请加入俱乐部
Route::any('api/club/common/addActivity','api/Activity/addActivity'); // 发布活动
Route::any('api/club/common/getJoinClubs','api/User/getJoinClubs'); // 获取已加入的俱乐部列表
Route::any('api/club/common/getClubUsers','api/Club/getClubUsers'); // 获取俱乐部人员列表
Route::any('api/club/common/getActivity','api/Activity/getActivity'); // 获取俱乐部活动
Route::any('api/club/common/getClub','api/Club/getClub'); // 获取俱乐部
Route::any('api/club/common/updateClubInfo','api/Club/updateClubInfo'); // 更新俱乐部
Route::any('api/club/common/userAuth','api/User/userAuth'); // 人员授权
Route::any('api/club/common/uploadFile','api/Upload/uploadFile'); // 图片上传

Route::any('api/club/common/applyActivity','api/User/applyActivity'); // 活动报名
Route::any('api/club/common/quitClub','api/User/quitClub'); // 30退出俱乐部
Route::any('api/club/common/updateUserInfo','api/User/updateUserInfo'); // 31更新用户信息
Route::any('api/club/common/getUserInfo','api/User/getUserInfo'); // 32获取用户信息
Route::any('api/club/common/getActivityInfo','api/Activity/getActivityInfo'); // 33获取俱乐部活动详情
Route::any('api/club/common/getAttendance','api/Club/getAttendance'); // 34出勤表
Route::any('api/club/common/getSignList','api/Activity/getSignList'); // 35活动报名名单
Route::any('api/club/common/getPhone','api/User/getPhone'); // 36获取手机号
Route::any('api/club/common/withdrawActivity','api/User/withdrawActivity'); // 37取消报名



// Route::rule('/api/club/common/uploadUserInfo','/api/User/register');// 定义POST请求路由规则



// return [
//     '__pattern__' => [
//         'name' => '\w+',
//     ],
//     '[hello]'     => [
//         ':id'   => ['index/hello', ['method' => 'get'], ['id' => '\d+']],
//         ':name' => ['index/hello', ['method' => 'post']],
//     ],
//
// ];
