# 7天gee-web框架



## 功能

1. 路由： url路径 映射到 回调函数（处理逻辑） (动态路由 用 tire，前缀树，用map存储 动态路由参数)
2. 工具集：cookie，header等封装好。（封装的本质就是 隐藏细节，而暴露的接口就是抽象，让别人依赖抽象，只要接口没有变，那依赖这个接口的就不用变，而细节很容易变，而且还可以保护数据，以及提高复用性）
3. 中间件 （中间件就是 aop，多是与业务逻辑无关的，比如事务，幂等性，日志，传入对应的**回调函数** & 也要出入**处理逻辑**（即函数 & 参数））



## 主要流程



### 路由

实际上 网络通信都是 由 IP + port来找到对应的进程

但是url 路径参数怎么找到 对应的回调函数呢

用 tire（前缀树，存key ，再用key得到 handlerFunc）

那为什么不直接用 map[string] handlerFunc

因为动态路由啊，动态路由传入的 url路径，是变化的

but 有了 tire，可以将动态路由 和 key对应（key 是 用户传入的路径）

比如 /hello， /hello/:id (:id ，这个id就是动态路由)

有了tire ，将url.Path 找到对应的 key（用户传入的） （比如 /hello/3 通过 tire 找到  /hello/:id）

then 就可以找到 funcHandler



### 上下文

封装了各种参数

request

response

handlers []handleFunc  // 因为还有非常多的中间件啊（就是aop）

method // 请求方法 比如 get post delete put

pattern // url路径

它封装了工具集的参数



### 分组

分组就是 springBoot中的 controller

会有很多的 controller，then也会有很多的 group

中间件也是在 分组的基础上的

添加路由也是在路由基础上的



```go
r := gin.Default()
v1 := gin.Group("/hello")
v1.GET("/yyj", func (c *gin.Context) { // 在分组上添加路由
	c.Json(http.StatusOk, "yyj is son")
})
```

So addRoute应该也是在Group的基础上

那引擎应该是 超级分组，它是所有的分组的祖先，给他添加路由，就是全局路由





那路由怎么找到，group上的中间件呢，很简单，if url.path的前缀 == group.prefix 那就可以将group的中间件 给 url对应的 ctx了





### panic处理



go语言没有 try catch机制

如果发生了panic没有处理，就直接寄了

how do it

if 在一个函数中发生了 panic，可以用 defer + recover 处理

处理了，这个函数就不会再执行了，but 进程不会寄

我们可以 在超级路由第一个中间 就是 一个错误处理函数 

```go
func Recover(c *gin.Context) {
	defer func (c * gin.Context) {
        err := recover()
        if err != nil {
            
		}
	} 
}
```



### template 

这个是 加载前端的东西

我觉得这个我不想学



## day1 http基础

想要 进行网络通信

1. 服务端 listen(network, addr)
2. 客户端 connect(network, addr) // addr 是服务端的



而http，network是 确定的。 so 确定addr就可以

```go
http.ListenAndServe(addr, handler) // 会将所有的，连接addr的请求，都交给 handler处理（他是个回调函数 & 开协程）
// 如果不行让 handler 全部处理，可以
http.HandleFunc(pattern string, handler) 
l := net.Listen(network, addr)
http.Serve(l, nil)
```

思路：

让 Engine 实现 ServeHTTP接口，http.ListenAndServe(addr, engine) // 接管所有的http请求，在请求中，根据 req.URL.Path 找到对应的 处理回调函数



Engine 实现 Pattern 到 handler 的映射

后面的 router 会实现 req.URL.Path 到 Pattern的映射



## day2 Context



Context 用来 封装，req 和 w。因为一次http处理，本质是 读取 req，then handler ，then 写入 w，发送给 服务端

封装的思想（隐藏细节 & 暴露抽象接口）

而且 它是动态路由参数的保存者 根据req.URL.Path 解析的动态路由参数，保存在 Context中



## day3 Trie

前缀树，实现了动态路由

insert（method, pattern）// pattern是用户注册的路径 比如 /hello/:name

search(method, path) // path是 http中url路径，比如 /hello/yyj 我们要将 yyj参数 存入 name，实现动态路由

如果是 : 开头，那就直接是匹配的

tire 它是一个 key value结构，对于 路由来说，key 和 value 都是 pattern，关键是 根据 path 找到 pattern



tire它是一个树结构，有孩子的



## day4 分组控制

这个简单，将分组的前缀 + pattern，就是完整的pattern了

```go
r := gee.New()
g := r.Group("/yyj")
g.addRoute("/hello", handler HandleFunc) // 完整路径就是 /yyj/hello
g.addRoute("/name", handler HandleFunc) // 完整路径就是 /yyj/name

// 
```

so，Group的关键是保存 prefix & 实现 addRoute方法，就是将 路由的方法，交给 Group负责

engine也可以，那engine就继承 Group咯



# 7天gee-cache

分布式缓存

分布式： 高可用 高流量 高存量  缺点：管理（发现与注册中心，gateway（对外暴露的统一接口）），一致性， 延迟，复杂性

缓存：一致性 穿透，击穿，雪崩，锁（互斥 ）网络（连接池 & 异步IO & 批处理）

如果一个东西是 大家都可以访问的，就可以用来管理分布式（分布式锁 全局唯一ID 限流）



## 功能

淘汰机制 （lru算法，因为局部性原理）

一致性 （延时双删 or binlog + canal + mq）

管理 

通信 http服务器（1. IP+ port 2. url）





# 7天gee-rpc

## 序言

rpc 就是 远程过程调用

调用本地方法，本地方法通过网络通信，调用别的微服务方法

ok 那就有 本地方法 到 远程方法的**映射**（用服务名 & 方法名）

函数 应该有 （入参 返回值）

映射 就是路由，和gee-web框架差不多



但是网络传输，数据有**编码与解码**，我们应该有多种 编码方式，可以将编码方式用json数据，存入 传输数据中



我们应该依赖抽象，不应该依赖具体。不能和别的通信，硬编码 IP + port。那就引入了**服务注册与发现中心**，还有**负载均衡**。

如果挂了，还有删除。开了新的，也要加入。so，**开启服务**时，要通知**服务注册与发现中心**（so，我们应该知道中心的ip + port），**也要心跳检测**。

客户端，也要知道 中心，so也要知道IP+ port。服务端也应该通知客户端，服务端（name + IP + port）



我们也**应该支持 常见的协议**。



总结

1. 解码与编码。（将解码与编码方式写入数据）
2. 发现于注册中心
3. 负载均衡（客户端，不同的，可以自己传入回调函数）
4. 协议的支持（http，直接调用tcp的协议，太不方便了，而且不够抽象）
5. 健康检测（用ping pong来检测，if 寄了 then 广播客户端）



## 1 服务端与消息编码

codec，就是编码方式

option 封装了（codecType, MagicNum（统一的协议标识））

header 封装了 ServiceMethod（路由）， args（入参），reply（returnValue）, err 

server 与用户交互 （1. readOption( 编解码) 2. readRequest 3. handlRequest 4. sendResponse)

readRequest一直读（协程，不怕阻塞），读完一个就用协程调用 handleRequest（handle完，就会send数据，因为并发，要互斥，用syn.Mutext 保证只有一个 send）



## 2 高性能客户端

客户端 要实现的功能 

1. 传入 server地址建立连接
2. 调用Call 进行远程调用(Call(ServiceMethod sring, args interface{}, reply interface{}) error)



具体  Dial(network, addr, opts…) // opts 是通讯的编码方式

​		then Dial中 调用serverConn -> serverCodec -> 一直监听读（receive方法）

​		receive读到了 then 将body 解码到 reply 



type call struct 封装了 一次call的参数

Header 封装了 seq（标识call），serviceMethod ， error

body 没有这个结构体 但是 一次传输 由 header 和 body 组成

客户端 中body 是args，服务端是 reply

异步 和 同步调用

异步就是 调用Call，send请求就好，不用等 接受，要结果时 Call.done()。同步一般用 chan

同步 调用 异步 + done（）就可以了



call是要保存到调用结束的，用map[seq]*Call

register remove 终止





## 3 服务注册

一个 server 中可以有很多个 服务（就是一个类，它的方法就是 被调用的）

为了 可扩展性，应该all 类型都可以 then用interface{}, 而且我们要知道 类名 方法 类型等信息 用反射

then serviceMethod ，用service找到类，Method找到 类的方法，Method的参数，根据反射信息 new，

then将args（网络传输的，decode），调用，将reply 发送给客户端

数据的发送和接受 由codec负责



## 4 超时处理

1. go 异步调用
2. select 看是 go异步调用快，还是超时快。（异步 then 带来了 通信  so 用chan）



连接，直接有DialTimeout



## 5 支持HTTP协议

只是连接用的http协议，连接完成后还是用的rpc协议

服务器的开始还是要，用 net.Listen()的

而 http开启，有两种

1. http.ListenAndServer(addr, handler Handler)
2. http.Server(conn net.Conn, nil)



## 6 负载均衡

是一种策略，有默认值。也可以传入回调函数



## 7 服务发现与注册中心



如果只有一个，就会有单点故障，怎么办。用分布式。那就可以用中心名 来调用，then可以 解耦 & 可以负载均衡。

而中心名 可以 借鉴 dns。来解决路由

但是修改不好用了，因为还是要有一个中心来通知，还是导致了单点故障。
