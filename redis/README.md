*Redis资料收集，配置文件的翻译和整理*
----

```shell
redis-benchmark # redis性能测试工具
redis-check-aof # AOF文件修复工具
redis-check-rdb # RDB文件修复工具
redis-cli       # redis命令行客户端
redis-sentinal  # redis集群管理工具
redis-server    # redis服务进程

redis-server /etc/redis.conf #启动redis服务
redis-cli shutdown           #关闭redis服务
```

#### 文件说明
<pre>
.
├── install.sh | 自动安装脚本
├── README.md
├── redis.conf | 配置文件翻译整理
└── t.php      | 简单的测试文件
</pre>

#### 其他
1. php 操作redis有两种主流的方式：
<pre>
  A.使用redis 的PHP扩展(推荐)
    扩展地址：https://github.com/phpredis/phpredis
    中文文档：http://www.runoob.com/redis/redis-php.html
    两个可以对照着看，一个中文，一个英文，方便找方法<br>
  B.使用这个PHP类库的时候就不用redis的PHP扩展：https://github.com/nrk/predis (这个主要是不知道有些什么方法，以及怎么用)
</pre>

2. Redis GUI 管理工具 : https://protonail.com/keylord/download`
