# gprc



实现了 全程过程调用

通过 网络 来调用 其他进程的函数 



核心 就是调用 函数 



通过 服务名 + 函数名 + 参数 + return， 来调用



## 引入问题

跨微服务的 调用

**屏蔽了 网络的细节** 

but 没有 解决 ip + port的硬编码（分布式通信 要用 注册与发现中心）

也没有 解决 负载均衡



## 使用流程



### 服务端

 

#### 一 定义 proto文件

将 通信的 函数 和 函数要用到的参数 & return ，用proto定义



```protobuf
syntax = "proto3";

package pb;

option go_package = ".;pb";


message HelloRequest {
	string Name = 1; // 1 标识字段顺序
	repeate string A = 2; // repeate 代表它是 数组
	
}

message HelloReply {
	string message = 1;
}


service Greeter { // 定义服务器
	rpc SayHello(HelloRequest) returns (HelloReply); // rpc 就是要给其他微服务调用的函数
}
```



之后通过 protoc –go_out=. –go-grpc_out=. *.proto

来将 proto 文件编译成 go struct 文件 和 go service文件

service 中有很多方法

我们通过继承（嵌入），重写SayHello方法 来实现自己的功能



#### 二、定义类 来继承 service

重写 SayHello方法



#### 三、监听端口，注册服务



```go
func main() {
    // 创建监听端口，服务端
    lis, _ := net.Listen("tcp", ":9090")
    // grpc大的服务器
    s := grpc.NewServer()
    
    // 将 自己的服务注册
    RegisterGreeterSevice(s, &HelloService{})
    
    // 启动服务
    s.Serve()
    
}
```

 

### client

#### 一 定义 proto文件

将 通信的 函数 和 函数要用到的参数 & return ，用proto定义 

和服务端一样



#### 二、发起连接 NewClient 调用 函数

grpc.Dial

Client 调用 即可







## key

分布式 微服务







# proto

它是一个数据传输协议



## 引入问题

如果 对于 内存有IO

怎么传输数据

proto 是二进制，冗余数据少

快，不同于 xml，json文本数据



## 使用



## 一、定义 proto文件



和grpc一样，但是没有 service



### 二、Input 时Unmarshal

对于 内存（应用进程），proto是看不懂的，要 转换为 struct



### 三、Output时 Marshal

因为要传输 ，要转换为 二进制流





## key 

对于**内存 有IO**时

比如 数据库，http，rpc都是

狭义的说，如果要进行网络IO（网路IO 连接池），那就要用到 数据传输协议

Json，xml都是

input 解码（反序列化)，output 编码（序列化）