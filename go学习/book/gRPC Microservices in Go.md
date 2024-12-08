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

