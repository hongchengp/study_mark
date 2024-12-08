# Go 并发编程实战课



## 基本并发原语



### Mutex

锁

解决 并发访问 **共享数据**

只要它会被 并发访问（除非只有 读）

就要用 锁来保护

之后锁的优化 再想，先完成 基本功能



本质 还是 **多个访问只有一个能够 成功**

go的 Mutex 没有用操作系统中的并发原语

使用 cas 来实现  free-lock，不用进行 线程的切换



#### 常见错误



##### 没有成对的 lock & unlock

使用了 lock 后面一句直接使用 defer unlock

但是defer只有 在函数结束后 才可以 调用 



但是我想 减少 锁的颗粒度呢

嘿嘿嘿

使用 函数包装好就可以了

函数就是 lock的使用范围



#####  Copy 已使用的 Mutex


ll




##### 重入

go语言的 Mutex是没有重入的

会导致 死锁

我们只需要加入 锁是who持有的 & 锁的重入数



##### 死锁

这个就不说了



### RWMutex

优化 并发读写，中读多写少





### 优化

1. 锁的颗粒度 （垂直切分，比如12306中购票，将锁，分为每个站的锁）
2. 分片锁 (1. 使用hash 2. 每个对象都只有自己的锁)



### key

共享数据







### WaitGroup



解决 **并发**-**等待** 问题

比如 解决 一个主线程要 等待 3个任务的完成



```go
func main() {
	var wg sync.WaitGroup
    for _ = range 3 {
        wg.Add(1)
        go func() {
            time.Sleep(10 * time.Second)
            wg.Done()
        }
    }
    
    wg.Wait()
}
```

就是等待**任务的完成**





#### 使用原则



**等所有的 Add 方法调用之后再调用 Wait**

Wait 一定要在 Add调用之后 才使用



#### key

并发等待（等待任务结束，没有数据传输）





### Cond

条件变量 

使用场景 

线程（协程） 进行  通信（同步）



在go中使用的 非常少 因为 可以使用 chan来进行代替



#### 使用

```go
func main() {
	// cond 是要和锁进行bind 要上锁后才可以wait, 但是 通知不需要 持有锁
    var mu sync.Mutex
    cond := sync.NewCond(&mu)
    
    // 1. 上锁
    mu.Lock()
    defer mu.Unlock()
    
    // 2. 检查条件 不满足 就循环等待，为什么循环，因为可能虚假唤醒
    for case {
        cond.Wait()
    }
    
    
}


// 唤醒操作 

func f(c *sync.Cond) {
    c.Sinal() // 唤醒一个，小心 死锁
    
    c.BroadAll() // 唤醒all，但是效率低，因为竞争状态很严重
}
```



#### key

并发通信

任务队列中很常见





### Once

只执行一次



多用于 单例饥饿初始化



#### 实现

两个方案

1. atomic 来标识有没有初始化
2. 使用锁



不能用 atomic，因为可能初始化很慢，改了 atomic 虽然只有一个初始化，但是 访问这个资源时，可能还没有初始化完成

so 使用锁（双check优化（保证状态没有被修改），就是用来加载资源（缓存，单例））



``` go
var resource interface{}

func f() interface{} {
    var mu sync.Mutex
    if  resource != nil {
        return resource
    }
    
    mu.Lock()
    defer mu.Unlock()
    if resource != nil {
        return resource
	}
    resource = NewR()
    return resource
}
```





#### key

加载 单例资源

但是 对于 缓存加载不好用





### Pool



#### 使用场景

池技术，减少 **资源 初始化和销毁的开销**

比如 连接池（网络IO），线程池 



#### 使用

抽象方法

1. 初始化
2. Get
3. 归还资源
4. shutdown (线程池)



#### key

资源复用





### Context



#### 引入问题

父子协程数据传递 & 协程生命周期



#### 使用 

数据 

使用 set & get



get方法应该是并发安全的

怎么解决 呢，使用锁来保护呀 **共享数据**



#### key

父子协程数据传递

协程的生命周期管理



## Chan



