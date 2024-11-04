![image-20240428163229598](../../../../../AppData/Roaming/Typora/typora-user-images/image-20240428163229598.png)

cms主要是为了提高响应时间

所以呢在 回收策略是 标记清除

为什么呢

因为如果是整理或复制的话，引用对象的地址就会变，如果并发就会导致地址错误

所以要用标记清除

主要用于老年代

我们之前说过内存碎片太多了，还是要整理的，但这次要花很多时间



# 主要流程



![](../../../../../AppData/Roaming/Typora/typora-user-images/image-20240428163311152.png)

为什么要**重新标记**呢

就是呢并发场景下，可能会发生一个对象没有被引用了，但是同时又有别的对象引用它了，但是它被标记为垃圾了，

会被清除，发生错误

怎么办

用重新标记，且防止并发问题，这个时候Stop-The-World

![image-20240428164228296](../../../../../AppData/Roaming/Typora/typora-user-images/image-20240428164228296.png)

![image-20240428164443641](../../../../../AppData/Roaming/Typora/typora-user-images/image-20240428164443641.png)

就是A它改变了引用，就在标记过程中，将它改为还未遍历完

这样它就会重新遍历，它引用的对象就不会变成垃圾\

![image-20240428163336328](../../../../../AppData/Roaming/Typora/typora-user-images/image-20240428163336328.png)