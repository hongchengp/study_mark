# 什么是DIct

![image-20240509170209690](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509170209690.png)

![image-20240509170219328](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509170219328.png)

dictEntry ** table 是什么呢？ 它实际上是指针数组，它的节点其实是链表

dict就是字典，用的是hash+mod，如果冲突就连在链表上



# Dict的扩容

![image-20240509170457899](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509170457899.png)

![image-20240509170512637](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509170512637.png)



# Dict的rehash

![image-20240509170548779](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509170548779.png)

就是重新创建hashtable

但是如果hash表非常大，如果在用同一段时间完整的复制，会占用cpu

怎么办，每次操作它时，就复制一个桶（就是hash + mod 后的那个值） 也有lazy的思想



![image-20240509170931097](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509170931097.png)

![image-20240509170945631](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509170945631.png)



那rehash时，插入时怎么办

直接插入ht[1]

删除就两边都删，如果有的话

查询时，就两边都查

