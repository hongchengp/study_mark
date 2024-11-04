## 进程

进程是计算机分配**资源的基本单位**，它是运行起来的程序



特征：

1. 动态性
2. 结构
3. 并发
4. 异步
5. 独立





## 线程



线程的状态 （计算机操作系统的，我不写了）



java的线程，在阻塞状态是可以**打断的**



### 打断

核心 让线程抛出异常

比如 

try {

sleep()

} catch () {

 // 如果是打断的异常

就可以 执行相应的措施

比如：退出线程，有了这个，就可以防止死锁，让线程自己死

}



如果线程 在**运行状态**它是**不会抛出异常的**，而是将 异常flag 赋值为 true

如果 线程 在 **阻塞状态**，会抛出异常，将异常flag 清除 



用这个就可以 线程优雅的 退出





### park & unpark

这个非常好用，park就是让线程阻塞

unpark，让线程恢复运行



如果线程的 打断flag = true，park是不能阻塞的，很正常，因为打断，就是不让你阻塞

而且 

先unpark 

在 park是不会阻塞，但是只会一次park不会





## 同步

同步，顺序的执行



### syn

object  -> monitor

如果对一个对象上锁，那它的mark word，就会存一个 monitor的地址

（ownerThread（上锁的线程，重入和解锁要用），wait（用await，自愿放弃锁），block（没抢到锁的），count（重入计数））



syn，功能全，但是用它，要用操作系统的mutex，要系统调用，开销大

上锁时，如果多个线程同时竞争，怎么办（**用cas**， 保证多人修改只有一人成功，底层是硬件 锁定 相应地址）



cas （void *addr, expect, next） {

 // 只要锁定 *addr, 这个地址，同时只有一个人才能访问

}

java 是 this指针 + 偏移量 + expect + next

调用的是底层的 unfase类 （太底层，java是不让调用的）



### 锁升级

syn 系统调用，开销太大 （要修改各种的 寄存器，因为 程序 = pc寄存器（要运行的地址）+ 上下文（就是寄存器））

所以在并发度低时，用别的锁会更好



### 偏向锁

在mark word，记录偏向的ThreadId （它改mark word时，也是用的cas）

如果 别的线程（不是偏向的ThreadId）来，它就会升级为 轻量级锁

它只用看对象头就可以了，开销非常小



### 轻量级锁

它是生成 锁记录 （生成到 上锁线程的 **栈帧上**）

如果要重入，就多生成一个

unlock，就少一个

如果在上锁中，有别的线程来，它就会升级到 重量级锁

就是 syn



### wait - not

await - notify

使用



```c
condition = lock.newCondition();
lock.lock();

while (不满足) {
    condition.await(); // 条件变量一定是 锁对应的，而且要上锁了，才能 await
    // await会主动释放锁，进入waitSet，用它可以解决 线程间同步
    // 线程间同步，思路用这个差不多
}
```



### 总结

偏向锁 ：从头到尾 只有一个线程，就可以一直用

轻量级锁；在用的过程中，没有其他线程来，就可以一直用 （为什么呢，因为它没有 阻塞队列，等待队列等）

syn：不是上面的，就可以一直用



## 无锁



### cas

无敌

它是后面的基础

如果没人改，就成功

乐观锁



底层就是，让传入对象的 地址只能 让一个线程 访问，实现多个改，只有一个成功



### 原子类



它就是 让对一个对象的修改 原子

底层还是 对地址的锁定



```c
addr (void *addr, next) {
    int expect = *addr; // 要多线程可见，用volatile修饰
    if (cas(*addr, expect, next)) {
        break; // 如果不成功，就会一直的循环，如果线程竞争太厉害，也是不好的
    }
}
```

他现在都是只能 + -

如果我要乘除，自定义操作怎么办

传入 操作方式，就是函数式编程 

interface {

func ； // 接口只有一个抽象方法，可以直接用lambda传入

}



比如我要 * 10



```c
operatorAtom (void *addr, func (value, num)) {
	cas(addr, *addr, func(*adrr, num));// func 就是回调函数，只要符合 对应的接口就可以，回调函数，就是自定义操作
}
```





### LongAddr

如果线程比较多，cas成功率就会很低

怎么办

让每个线程只操作自己的就好了 （就是将资源 与 线程绑定，底层是 cells数组，这个数组是lazy操作，只需要加载一次，用dlc）

让每个线程 自己加

要用时，用 sum将每个线程加的一起加入就可以



### DLC

double lcok check

一般是用来加载缓存 和 单例的

``` c
void dlc () {
	if (null) {
       	lock;
        try {
            if (null) return;
            // 操作; 一般是缓存，单例， 
        } finally {
            unlock;
        }
    }
}
```



#### 缓存伪共享

每个cpu，都有缓存（有缓存就有 一致性）

缓存 是用 缓存行为单位的

如果别的cpu修改了同一个缓存，那这个cpu的缓存就要作废了（缓存一致性协议 MSIE）

所以，对于 LongAddr，它用的 **cells数组要解决缓存伪共享**

它加载 cell，是用cas的，因为多人竞争，只有一人成功

失败的 继续循环 or 退出



### 原子引用

也是锁住引用的地址



### 不可变类



比如 final

Stirng （用的CopyOnWrite）



### 无状态

没有状态，就没有读和写，肯定是线程安全的



### CopyOnWrite

它实际上有两个 对象

如果要改，就在副本上改

在改的过程中，读就读旧的对象

它是弱一致性的

修改时，开销非常大



### Local

Thread为什么是线程安全的

**因为，每个线程都有一个ThreadLocalMap**，它是线程独有的（Local）

key 是 threadLocal，value 就是要存入的值

为什么key是threadLocal, 因为threadLocal一般是线程共享的，**使用 threadLocal.get(), 实践上会到ThreadLocalMap中找**

但是在 map中，就会一直存 key 和 value，除非手动删除

但是我们有些时候不知道什么时候删除 threadLocal，因为它是线程共享的

how do

threadLocal，一般是主线程创建的，如果主线程删除了，那它就没有用了

**所以用到了 弱引用，只要主线程，不引用他了，gc时，就会被删除**

但是val不会啊

只能我们自己删除 or 让定时任务删除



ThreadLocalMap就是数组，不用加上链表

如果冲突，就+1 or 其他，直到找到空位



## 线程池



组成 ：

1. 任务队列 （线程安全的，用锁和条件变量保证，用的阻塞队列，它会有 最大容量）
2. worker队列（就是工作线程，在线程中是lazy初始化的，不用显示给出）
3. core （核心线程）
4. max（最大线程，核心线程外的线程，超时空闲，就退出）
5. timeout （超时时间的数字）
6. TimeUnit (超时时间单位)
7. ThreadFactory （new 线程的操作，就是回调函数）
8. 拒接策略 （也是用的回调函数，符合接口就可以）



使用时，只用给出除了 第二参数的 ，其他7个参数



#### BlockingQueue

```java
class BlockingQueue {
    // Runnable就是task，它就是类，回调函数用的参数，就是它的字段，run（）函数就是操作
    private Deque<Runnable> deque =  new LinkedList<Runnable>;;
    private int capacity; // 最大容量
    private ReentrantLock takeLock = new ReentrantLock(); // take锁，拿的时候的锁
    private ReentrantLock putLock = new ReentrantLock(); // put锁
    private Condition notEmpty = takeLock.newCOndition(); // 空，对应takeLock
    private Condition notFull = putLock.newConition(); // 满，对应putLock
    
    public BlockingQueue (int capacity) {
        this.capacity = capacity;
    }
    
    public void signalNotEmpty() {
        takeLock.lock();
        try {
            notEmpty.signal(); // 要上锁才能用条件变量哦，还要是对应的锁
        } finally {
            takeLock.unlock();
        }
    }
    
    public void signalNotFull() {
		putLock.lock();
        try {
            notFull.signal();
        } finally {
            putLock.unlock();
        }
    }
    
    public Runnable take() {
		Runnable tmp; 
        takeLock.lock();
        try {
            while (deque.isEmpty()) {
                notEmpty.await(); // 要反过来读，等待不空
            }
            tmp = deque.removeFirst();
        } finally {
            takeLock.unlock(); // finally 用的是异常表实现的，他在所有后面都插入的finally里面的操作
        }
        
        signalNotFull(); // 不能在 try里面用，否则会死锁 
        return tmp;
    }
    
    public void put(Runnable task) {
        putLock.lock();
        try {
            while (deque.size() == capacity) {
                notFull.await(); //等待不满
            }
            deque.put(task);
        } finally {
            putLock.unlock();
        }
        signalNotEmpty();
    }
    
    // 带超时的加入，防止线程一直等待，用这个，可以杀死空闲非核心线程
    public Runnable poll(long timeout, TimeUnit timeUnit) {
        long nacos = timeUnit.toNacos(timeout);
        Runnable tmp;
        takeLock.lock();
        try {
            while (deque.isEmpty) {
                nacos = NotEmpty.awaitNacos(nacos);
                if (nacos < 0) {
                    return null;
                }
            }
              
            tmp = deque.removeFirst();
        } finally {
            putLock.unlock();
        }
        signalNotFull();
        return tmp;
    }
}
```



#### ThreadPool 

等待我复制过来，写不过禁了



它是非公平的，因为new Threa（Runnable）

这个Runnable是，会直接传给线程执行的，它里面有task，如果core线程满了，而且队列满了，还来线程，会直接给new Thread使用





### Timer

它是单线程的，前一个寄了，后一个也寄



### schedule

定时 & 周期任务

但是我觉得不好

用 MQ不就好了

## aqs

组成：

1. state (状态，记录上没上锁，重入几个，信号量也可以用这个表示)
2. head （blocking队列的头）
3. tail （尾）
4. ownerThread （锁属于那个线程）

它是原子类，ReentrantLock，读写锁，countdown等等用它实现

**它底层，用 cas & volatile实现原子**

**上锁竞争时，cas state， 也会用双端锁 DLC来检查**

成功才是上锁，否则就自旋（因为如果自旋成功，就不用系统调用，切换线程）

也可以**公平**，在自旋时，检查自己是不是最前面的



它线程的阻塞和恢复，用park 和 unpark

核心：cas & DLC

unlock时，又前一个节点还恢复 后一个节点 （node也是有状态的）

0 不用会恢复下一个node

-1要，那它怎么知道他又后继节点呢，它的后继节点知道 （但是头节点没有前驱节点的，用dummy（哨兵节点））

恢复用 unpark



而且它删除节点很特殊 （后继节点 = 前， 去掉前，因为有dummy，所有node都有 前驱节点）



### reentrantLock

重入 用 state & ownerThread实现

```java 
if (state != 0) {
} else if (ownerThread == currentThread) {
    // 重入，state + 1 
    // 释放时，state - 1， 减到0才真正释放
}
```





### 读写锁

读读可以重入

读写和写写不可以



也是用 aqs实现

state 高 16位代表读，低16代表写

unlock时，如果第一个node 是 shared（node 也是 shared 和 独占的），那它就看后面的节点是不是

shared，是就也释放（释放也应该一个人释放，用cas）



写锁时，是可以重入读锁的（因为一个线程只能有一个运行的栈帧，他不可能同时读写）

读锁，不可以重入写锁，so 如果要用写锁，要先把读锁释放



### countDownLatch

它和join很像，但是join一定要线程死了才可以

它只需要 线程用await就可以

到了0，调用它的线程才能使用

底层也是 aqs，用cas就可以了



### 条件变量

while （true） {

cas(); // 就可以实现

}





## 并发包



### ConcurrentHashMap

它是aqs （cas）， LongAddr，细颗粒锁的集成



HashMap的底层是数组 + 链表

读是不上锁的

**如果要修改链表 （他会对这个链表上锁，非常好，因为锁的粒度非常小，而且是线程安全的）**

rehash，只会让一个线程开启 （cas）

**其他线程（增删改），在rehash会帮忙，rehash是以一个链表为基本单位的（锁住一个链表就可以了）**



HashMap的size，用的LongAddr（cells的加载，lazy的，也要用dlc），它采用分段（资源只属于一个线程）

让cas成功率增加，忙等概率减少



rehash也是两个 dict

redis的rehash是lazy操作，每次访问到了，就更新一个链表



### putIfAbsent 

他和redis 的setnx很像

它是线程安全的，对链表加锁就可以了

if 有了 就return entry

else return null & put

用它就可以实现 分布式锁

 

可以实现很多的线程安全问题



```java
// 多线程统计字母出现次数
// 用 ConcurrentHashMap + LongAddr
void tongjizhifu(char c) {
    ConcurrentHashMap m<Character, Integer> m1;
    m1.putIfAbsent(c, new LongAddr);
    LongAddr la = m1.get(c);
    la.addr(); // 当查看时 用sum累加，用分段来加速
}
```

