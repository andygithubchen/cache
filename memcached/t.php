<?php

//Memcached
$memcached = new Memcached();
$memcached->addServer('localhost', 11211) or die ("Could not connect");
$memcached->set('key', array('test','sdfsd'));
echo $memcached->get('key');
echo "\n";

//Memcache
$memcache = new Memcache();
$memcache->connect('localhost', 11211) or die ("Could not connect");
$memcache->set('andy', '2');
echo $memcache->get('andy');
echo "\n";

?>
