## 3.getting up and running with gRpc and Golang 



### 3.1 proto buffer

protobuf 是一种 传输协议

if 要进行传输 or 存储（存在数据库，其实也是要传输的）

then 要数据传输协议 

proto 它 是二进制的，而且冗余少，快

数据传输协议使用

对于 应用 OutPut 序列化，InPut 反序列化

so 输出时，用序列化

输入时，反序列化



#### 3.1.1 defining proto message

![image-20241206002028501](C:/Users/%E9%B2%B8%E4%BA%91%E9%9B%BE%E8%B5%B7/Desktop/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/study_mark/go%E5%AD%A6%E4%B9%A0/book/assets/image-20241206002028501.png)



message 就是 mapping 到struct

repeated -> 切片



### 3.2 generating stubs



stub 也就是 interface （因为 依赖倒置，依赖抽象）

stub 应该 service & client 都要有

![image-20241206002738402](C:/Users/%E9%B2%B8%E4%BA%91%E9%9B%BE%E8%B5%B7/Desktop/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/study_mark/go%E5%AD%A6%E4%B9%A0/book/assets/image-20241206002738402.png)

service 就是 暴露的 service 

rpc 就是它的方法

使用 protoc 编译 就可以给 服务器 客户端 用了

stub 就是接口

但是 编译后的 是struct but 不要紧，因为 客户端 依赖的 是 stub，是抽象的



### 使用流程

核心逻辑 core 也就是 业务层



我们都知道 业务层 是会和 controller 和 mapper 交互的

它们之间的交互 应该是 解耦的，也就是通过接口来进行交互的

so 对于test，只需要通过 mock接口就可以进行 mock

对于六边形架构：port 就是interface(map controller service) adapter 就是 实现的类

对于grpc 架构，除了 http的controller，也有 grpc的 controller

只要 service 是对 协议解耦的，它们就可以进行复用

为了 充分的解耦，应该使用 依赖注入(那些ip+port, 工厂方法啊，通过配置来 防止硬编码)

这些就是 grpc 架构上的设计



但是 if A 调用 B呢

也就是A依赖B

so 要通过 接口来进行解耦

也就是 A 依赖B的controller interface （grpc的 interface）



B的设计 还是 上面的 六边形架构

关键是 A怎么依赖B呢

它们是有 网络通信的，也就是 A是客户端

so A可以 通过grpc中的 stub来进行通信（grpc 的controller的interface）

then 我们来看看实现吧

![image-20241208123344803](C:/Users/%E9%B2%B8%E4%BA%91%E9%9B%BE%E8%B5%B7/Desktop/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/study_mark/go%E5%AD%A6%E4%B9%A0/book/assets/image-20241208123344803.png)

 

我说的不错吧

但是还是不应该直接通过 grpc stub来进行交互

在 order service中 声明一个 interface（就是用来 使用stub），通过interface 来进行交互

而这个interface的具体实现中 有 grpc PaymentClient，调用了 Charge方法



它的负载均衡有  client lb 

servicelb

client lb 就是 存 service ip + port 自己来选择用哪个

service lb 就是  client 通过一个中间服务器，这个中间服务器 再去调用 service 不好，多了一层网络IO，但是客户端只需要know 一个就好了



so，可以结合，if 没有ip + port， then 向 服务注册与发现中心 请求 ip + port

then 就可以缓存了，这样既可以 不用点到点，也不用增加一层



