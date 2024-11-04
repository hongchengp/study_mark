MyBatis输出结果
mybatis执行了sql语句,得到java对象.

![image-20240418134726950](../../../AppData/Roaming/Typora/typora-user-images/image-20240418134726950.png)

	resultType默认原则是: 相同的字段名赋值给相同的属性名

* 返回java对象
(1) ![image-20240418134742293](../../../AppData/Roaming/Typora/typora-user-images/image-20240418134742293.png)
java类型是任意的,只要有对应的属性的类就可以!可以自己创建一个只有 要求查询 字段的 属性 的类!!!

查询语句都要有resultType

处理方式:
1.mybatis执行sql语句,然后mybatis调用类的无参构造方法,创建对象
2.mybatis把ResultSet指定列值赋给同名属性.
注意: 即使select查询出来的要被封装到一个集合,但是后面resultType不可以写List哦, List<T> 就是写T就可以

![image-20240418134648640](../../../AppData/Roaming/Typora/typora-user-images/image-20240418134648640.png)

* 返回简单类型(select查询出来的数据是一行/一列)
例: select count(*) from ..

二.定义 自定义类型 的别名
	![image-20240418134638149](../../../AppData/Roaming/Typora/typora-user-images/image-20240418134638149.png)
第一种方式:
	![image-20240418134627239](../../../AppData/Roaming/Typora/typora-user-images/image-20240418134627239.png)

	这种方式一次指定一个类

第二种方式:
	
这种方式指定一个包,然后这个包中的所有类的别名就会变成类名本身.

但建议我们一般不使用别名.我们就用全限定名称最详细的

* 返回类型Map
	(1)列名是map的key,列值是map的value
	(2)只能最多返回一行记录,多余一行会报错!!

	![image-20240418134559832](../../../AppData/Roaming/Typora/typora-user-images/image-20240418134559832.png)
	
	![image-20240418134605871](../../../AppData/Roaming/Typora/typora-user-images/image-20240418134605871.png)



总结 reslutType 就是写mapper接口方法的返回类型