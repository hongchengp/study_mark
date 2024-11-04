# 什么是ZipList



![image-20240509171140603](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509171140603.png)

![image-20240509171212062](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509171212062.png)



# 为什么要ZipList



因为如果直接用链表，双端链表，它就要**两个指针，消耗的内存太多**



![image-20240509171337477](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509171337477.png)



![image-20240509171404838](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509171404838.png)



# 为什么它是链表

如果要代替双端链表，那它就需要找到next和pre

找nex很简单，因为previous_entry_length它的**前几个bit**是会表明它一个字节还是5个字节

同理encoding和content

那它就知道它的下一个元素的首地址



那pre呢，直接用previous_entry_length得到它的pre的首地址

那不是首地址可不可以，也可以但是呢

**那你就不知道content，encoding，previous_entry_length的长度，因为我们使用首几个字节标识它的编码的**



那为什么不用数组呢？因为它的元素长度是不一样的，不能依靠下表来遍历



![image-20240509173258037](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509173258037.png)

因为它可以在头尾插入删除，会让previous_entry_length发生连锁变化

![image-20240509173407551](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509173407551.png)