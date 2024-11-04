![image-20240509164533453](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509164533453.png)

![image-20240509164541733](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509164541733.png)

![image-20240509164859000](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509164859000.png)

它是有序的，但是底层是数组。那插入和删除要用O(N)



intset升级时，为什么时倒序复制呢？

因为扩容时，如果分配的空间也在原空间，正序复制时，就会把还未复制的数据覆盖

![image-20240509165839489](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509165839489.png)

**它为什么要用数组**

因为**链表的指针会占用空间**

而O(N)的插入和删除，只要数据比较少就可以接受

