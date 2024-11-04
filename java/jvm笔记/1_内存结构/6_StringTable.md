# 位置

在堆中，就是在方法区中



String Pool（字符串常量池）是StringTable的一部分



# 作用

存储“” 里面的字符串，只会存一次

存String对象

字符串的比较，如果是在String Pool中，只用比地址就可以，不用一个一个比

![image-20240427005540206](../../../../AppData/Roaming/Typora/typora-user-images/image-20240427005540206.png)

![image-20240427005615777](../../../../AppData/Roaming/Typora/typora-user-images/image-20240427005615777.png)

s1 = s2 + “a” 那么s1一定是new出来的，为什么呢，因为s2是引用变量，它在运行时是可以变化的，所以只能new

其实呢 底层是 先new StringBulider() 再 toString()

![image-20240427005856408](../../../../AppData/Roaming/Typora/typora-user-images/image-20240427005856408.png)

答案是

false

true

true

false



如果交换最后两行代码就是true

intern（）是这样的

对于 String s1 = new String(“a”) + new String(“b”);s1.intern();

如果字符串常量池中没有“ab”

那就会将s1的地址加入常量池，return “ab” 的地址

如果有的会 那就直接return ”ab“的地址

jdk1.6及以前 不会将s1的地址加入常量池，如果没有”ab“ 那就会创建一个，后return其地址



StringTable 底层是hashtable 数组加链表

如果hash冲突，那就加上链表

