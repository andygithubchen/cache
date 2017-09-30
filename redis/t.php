<?php

/**
 * 获取Redis实例
 */
function RedisApi() {
    $config = array(
        'host' => '127.0.0.1',
        'port' => 6379,
        'auth' => 123456
    );
    $redis = new Redis();
    $redis->connect($config['host'], $config['port']);
    $redis->auth($config['auth']);
    return $redis;
}

$redisObj = RedisApi();

$redisObj->set('xx', '12343new');
echo $redisObj->get('xx');




echo "\n";
?>
