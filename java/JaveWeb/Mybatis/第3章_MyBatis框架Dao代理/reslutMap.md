resultMap: 结果映射,指定列名与java对象的属性对应关系
(1)自定义列值赋值给哪个属性
(2)当你的列名与属性名不一样时,一定要使用resultMap来制定列名与属性的对应关系

resultMap是可以复用的!!



![image-20240418135025598](../../../AppData/Roaming/Typora/typora-user-images/image-20240418135025598.png)

![image-20240418135029790](../../../AppData/Roaming/Typora/typora-user-images/image-20240418135029790.png)

column是数据库的列名，property是Java对象的属性名，可以解决名称不一致的问题

![image-20240418135048220](../../../AppData/Roaming/Typora/typora-user-images/image-20240418135048220.png)

但是呢？在mybatisplus中用注解就可以解决