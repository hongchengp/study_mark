epoll是救星啊

1.它底层用是红黑树，当fd符合要求时，它会将该节点放入就绪链表中

2.它不用复制和遍历完整的数据，因为fd就绪时，会自己将该节点放入链表中

​	复制的是链表中的节点，所以它可以贮存非常多的数据，因为不用完整的遍历和完整的复制



为什么要红黑树呢，因为它增删改查非常快	

![image-20240509152430933](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509152430933.png)

![image-20240509152517010](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509152517010.png)
