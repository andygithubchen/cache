*memcache服务整理*
---

### 文件说明
<pre>
.
├── install.sh   | 自动安装脚本
├── memcache.php | memcache浏览器端图形监控界面文件，像部署web站点一样部署，在里面再配置一下就可以了。
├── README.md
└── t.php        | 简单的测试文件
</pre>


### memcache 作为后台服务程序运行
<pre>
/usr/local/memcached/bin/memcached -p 11211 -m 64m -d (如果是在root用户下，要用 -u root)
</pre>

### PHP 的 Memcached 客户端
<pre>
PHP 有两个 Memcached 客户端：“<b>PHP Memcache 扩展</b>” 和 “<b>PHP Memcached 扩展</b>”，这就是是我们搞混的地方。

<b>PHP Memcache 扩展</b> 用PHP 实现的，支持面向对象和面向过程两种接口，2004年就实现了，是老客户端，而且功能少，属性也可设置的少。
函数列表：http://php.net/manual/zh/book.memcache.php

<b>PHP Memcached 扩展</b> 基于 libmemcached 开发的，使用 libmemcached 库提供的 API 与 Memcached 服务进行交互，
只支持面向对象的接口， 2009年才实现，Memcached 扩展功能更加完善，支持的函数更多，比如支持批量操作，现在一般建
议使用 Memcached 扩展。
函数列表：http://php.net/manual/zh/book.memcached.php
</pre>


### Memcache 所有方法整理
```php
$mc = new Memcache();
boo  $mc->add ( string $key , mixed $var [, int $flag [, int $expire ]] );           # 增加一个条目到缓存服务器, $var：除了字符型和整型外，其他类型php会自动序列化再存; $flag：压缩存储的值，true压缩，false不压缩; $expire：存储值的过期时间，0永久，不要超过2592000秒。
boo  $mc->close ( void );                                                            # 关闭memcache连接
boo  $mc->connect ( string $host [, int $port [, int $timeout ]] );                  # 打开一个memcached服务端连接, $timeout：连接超时时间，单位秒。默认值1秒
int  $mc->decrement ( string $key [, int $value = 1 ] );                             # 减小元素的值, 只能用于整型类数据，不能用于set,add压缩生效的值，只会减到0，不会是负数。
boo  $mc->delete ( string $key [, int $timeout = 0 ] );                              # 从服务端删除一个元素, $timeout：删除该元素的执行时间。0表示立即删除，单位秒
boo  $mc->flush ( void );                                                            # 清洗（删除）已经存储的所有的元素, 不会真正的释放任何资源，而是仅仅标记所有元素都失效了，因此已经被使用的内存会被新的元素复写。
str  $mc->get ( string $key [, int &$flags ] );                                      # 从服务端检回一个元素, $key:要获取值的key或key数组。 $flags:不太清楚
arr  $mc->getExtendedStats ([ string $type [, int $slabid [, int $limit = 100 ]]] ); # 缓存服务器池中所有服务器统计信息。$type:要抓取的统计信息类型，可以使用的值有{reset, malloc, maps, cachedump, slabs, items, sizes}，$slabid:用于与参数type联合从指定slab分块拷贝数据，cachedump命令会完全占用服务器通常用于 比较严格的调试。
int  $mc->getServerStatus ( string $host [, int $port = 11211 ] );                   # 用于获取一个服务器的在线/离线状态, 返回一个服务器的状态，0表示服务器离线，非0表示在线。
arr  $mc->getStats ([ string $type [, int $slabid [, int $limit = 100 ]]] );         # 获取服务器统计信息, 和getExtendedStats()一样。
str  $mc->getVersion ( void );                                                       # 返回Memcached服务版本信息
int  $mc->increment ( string $key [, int $value = 1 ] );                             # 加一个元素的值,  只能用于整型类数据，不能用于set,add压缩生效的值，$value:只能是正整数。
mix  $mc->pconnect ( string $host [, int $port [, int $timeout ]] );                 # 打开一个到服务器的持久化连接, 和Memcache::connect()非常类似，不同点在于这里建立的连接是持久化的。 这个连接不会在脚本执行结束后或者Memcache::close()被调用后关闭。
boo  $mc->replace ( string $key , mixed $var [, int $flag [, int $expire ]] );       # 替换已经存在的元素的值, 当key 对应的元素不存在时将返回FALSE。,其他参数和Memcache::add()一样。
boo  $mc->set ( string $key , mixed $var [, int $flag [, int $expire ]] );           # 将 value(数据值) 存储在指定的 key(键) 中。 $var：除了字符型和整型外，其他类型php会自动序列化再存; $flag：压缩存储的值，MEMCACHE_COMPRESSED压缩，0不压缩; $expire：存储值的过期时间，0永久，不要超过2592000秒。
boo  $mc->setCompressThreshold ( int $threshold [, float $min_savings ] );           # 开启大值自动压缩, $threshold: 控制超过多大值时进行自动压缩。$min_saving:指定经过压缩实际存储的值的压缩率，支持的值必须在0和1之间。默认值是0.2表示20%压缩率。
boo  $mc->setServerParams ( string $host [, int $port = 11211 [, int $timeout [, int $retry_interval = false [, bool $status [, callback $failure_callback ]]]]] ); #运行时修改服务器参数和状态, $retry_interval: 服务器连接失败时重试的间隔时间，默认15秒。-1表示不重试。此参数和persistent参数在扩展以 dl()函数动态加载的时候无效。$status: 控制此服务器是否可以被标记为在线状态。$failure_callback: 允许用户指定一个运行时发生错误后的回调函数。
boo  $mc->addServer ( string $host [, int $port = 11211 [, bool $persistent [, int $weight [, int $timeout [, int $retry_interval [, bool $status [, callback $failure_callback [, int $timeoutms ]]]]]]]] ); #向连接池中添加一个memcache服务器
```


### Memcached 所有方法整理

```php
$mcd = new Memcached();
boo  $mcd->add ( string $key , mixed $value [, int $expiration ] );                                                                 # key已经在服务端存在，此操作会失败。默认0，0永久，不要超过2592000秒。
boo  $mcd->addByKey ( string $server_key , string $key , mixed $value [, int $expiration ] );                                       #
boo  $mcd->addServer ( string $host , int $port [, int $weight = 0 ] );                                                             #
boo  $mcd->addServers ( array $servers );                                                                                           #
boo  $mcd->append ( string $key , string $value );                                                                                  #
boo  $mcd->appendByKey ( string $server_key , string $key , string $value );                                                        #
boo  $mcd->cas ( float $cas_token , string $key , mixed $value [, int $expiration ] );                                              #
boo  $mcd->casByKey ( float $cas_token , string $server_key , string $key , mixed $value [, int $expiration ] );                    #
int  $mcd->decrement ( string $key [, int $offset = 1 ] );                                                                          #
int  $mcd->decrementByKey ( string $server_key , string $key [, int $offset = 1 [, int $initial_value = 0 [, int $expiry = 0 ]]] ); #
boo  $mcd->delete ( string $key [, int $time = 0 ] );                                                                               #
boo  $mcd->deleteByKey ( string $server_key , string $key [, int $time = 0 ] );                                                     #
arr  $mcd->deleteMulti ( array $keys [, int $time = 0 ] );                                                                          #
boo  $mcd->deleteMultiByKey ( string $server_key , array $keys [, int $time = 0 ] );                                                #
arr  $mcd->fetch ( void );                                                                                                          #
arr  $mcd->fetchAll ( void );                                                                                                       #
boo  $mcd->flush ([ int $delay = 0 ] );                                                                                             #
mix  $mcd->get ( string $key [, callback $cache_cb [, float &$cas_token ]] );                                                       #
arr  $mcd->getAllKeys ( void );                                                                                                     #
mix  $mcd->getByKey ( string $server_key , string $key [, callback $cache_cb [, float &$cas_token ]] );                             #
boo  $mcd->getDelayed ( array $keys [, bool $with_cas [, callback $value_cb ]] );                                                   #
boo  $mcd->getDelayedByKey ( string $server_key , array $keys [, bool $with_cas [, callback $value_cb ]] );                         #
mix  $mcd->getMulti ( array $keys [, array &$cas_tokens [, int $flags ]] );                                                         #
arr  $mcd->getMultiByKey ( string $server_key , array $keys [, string &$cas_tokens [, int $flags ]] );                              #
mix  $mcd->getOption ( int $option );                                                                                               #
int  $mcd->getResultCode ( void );                                                                                                  #
str  $mcd->getResultMessage ( void );                                                                                               #
arr  $mcd->getServerByKey ( string $server_key );                                                                                   #
arr  $mcd->getServerList ( void );                                                                                                  #
arr  $mcd->getStats ( void );                                                                                                       #
arr  $mcd->getVersion ( void );                                                                                                     #
int  $mcd->increment ( string $key [, int $offset = 1 ] );                                                                          #
int  $mcd->incrementByKey ( string $server_key , string $key [, int $offset = 1 [, int $initial_value = 0 [, int $expiry = 0 ]]] ); #
boo  $mcd->isPersistent ( void );                                                                                                   #
boo  $mcd->isPristine ( void );                                                                                                     #
boo  $mcd->prepend ( string $key , string $value );                                                                                 #
boo  $mcd->prependByKey ( string $server_key , string $key , string $value );                                                       #
boo  $mcd->quit ( void );                                                                                                           #
boo  $mcd->replace ( string $key , mixed $value [, int $expiration ] );                                                             #
boo  $mcd->replaceByKey ( string $server_key , string $key , mixed $value [, int $expiration ] );                                   #
boo  $mcd->resetServerList ( void );                                                                                                #
boo  $mcd->set ( string $key , mixed $value [, int $expiration ] );                                                                 # 将 value(数据值) 存储在指定的 key(键) 中。
boo  $mcd->setByKey ( string $server_key , string $key , mixed $value [, int $expiration ] );                                       #
boo  $mcd->setMulti ( array $items [, int $expiration ] );                                                                          #
boo  $mcd->setMultiByKey ( string $server_key , array $items [, int $expiration ] );                                                #
boo  $mcd->setOption ( int $option , mixed $value );                                                                                #
boo  $mcd->setOptions ( array $options );                                                                                           #
voi  $mcd->setSaslAuthData ( string $username , string $password );                                                                 #
boo  $mcd->touch ( string $key , int $expiration );                                                                                 #
boo  $mcd->touchByKey ( string $server_key , string $key , int $expiration );                                                       #
```
