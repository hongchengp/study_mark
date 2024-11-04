

![image-20240509164057980](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509164057980.png)

为什么要自己创造一个字符串呢

因为c语言的字符串是二进制不安全的

它读到‘\0’就结束了，如果字符串本身就有‘\0’,那它后面的就会被抛弃



那怎么实现二进制安全，我们**记录它的长度**。这个与java，还有tcp很像

**记录长度可以避免二进制不安全**



![image-20240509164438555](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509164438555.png)

![image-20240509164511408](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509164511408.png)