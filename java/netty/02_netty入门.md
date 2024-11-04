# 组件



## EventLoop



它就是 线程 + selector 

这个线程还可以执行普通任务



## Channel

就是fd



## Future & Promise

用来异步通信的

future要等任务执行完

promise就是go中的channel



## Handler & PipeLine

handler就是回调函数



pipeline是责任链，它是双向链表

节点就是回调函数



### 入栈函数

它是但接受到消息后执行的函数

就是read后，它是从前往后

主要用来读取客户端数据，写回结果（可以用普通函数来执行，之后就可以将结果写回）



### 出栈函数

它是发送消息前执行的函数

它是从后往前执行的

主要对写回结果进行加工



## ByteBuf

就是byteBuffer

它的读写指针是分离的





### silice

就是切片

底层用的地址是一样的

为了节省空间





其实我是要学习它的结构和实现思想的，比如并发的，