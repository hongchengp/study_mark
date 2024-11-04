//  如果是对本身修改怎么办，比如update user set add = add - 1 where id = 1

自定义sql 就是解决上面update的问题

```java
@Test
void testCustomSqlUpdate() {
    // 1.更新条件
    List<Long> ids = List.of(1L, 2L, 4L);
    int amount = 200;
    // 2.定义条件
    QueryWrapper<User> wrapper = new QueryWrapper<User>().in("id", ids);
    // 3.调用自定义SQl方法
    userMapper.updateBalanceByIds(wrapper, amount);
}
```

```java
void updateBalanceByIds(@Param(Constants.WRAPPER) QueryWrapper<User> wrapper, @Param("amount") int amount); 

// @Param(Constants.WRAPPER) 就是查询条件  或者是@Param("ew") 可以使用xml文件 映射sql语言
// @Param() 里面的是别名 可以在xml文件中使用
```

```xml
<update id="updateBalanceByIds">
    UPDATE user SET balance = balance - #{amount} ${ew.customSqlSegment} // 就是映射sql语句
</update>
```





![image-20240417010740222](../../../AppData/Roaming/Typora/typora-user-images/image-20240417010740222.png)