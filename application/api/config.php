<?php
//配置文件
return [
    'wxpay' => [
        'appid' => "wxd86b19313b6d5d96", //小程序应用id
        'secret' => "80eccc424e2816fae60cbd81c64a5673", //小程序secret
        'mch_id' => '1511779691', //商户ID
        'api_key' => 'cff966d3bfd35ae474707641c7597668', //商户平台自己设定的32位API密钥
        'notify_url' => 'https://wuwu/index.php/api/Pay/notify' //回调地址
    ],
];
